import json
import time
import uuid
import signal

from datetime import datetime, timezone
from typing import Dict, List, Optional, Any

import pymysql
from pymysqlreplication import BinLogStreamReader
from pymysqlreplication.row_event import (
    DeleteRowsEvent,
    UpdateRowsEvent,
    WriteRowsEvent,
)

from kafka import KafkaProducer

from . import die, err, logger

class MySQLCDCWorker:
    """
    MySQL Change Data Capture Worker
    Monitors MySQL database changes and publishes them to Kafka
    """
    
    def __init__(self, kaf_my_config: Dict[str, Any]):
        self.__kaf_my_config = kaf_my_config
        # pprint(self.__kaf_my_config)
        self.__cdc_is_running = True
        self.__kafka_producer = None
        self.__pymysql = None
        self.__binlog_stream = None

        # detecta el ctrl + c
        signal.signal(signal.SIGINT, self.__shutdown_listener)
        signal.signal(signal.SIGTERM, self.__shutdown_listener)
        
        self.__load_kafka_producer()
        self.__load_pymysql()


    def __shutdown_listener(self, signum, frame):
        """Handle graceful shutdown"""
        logger.info(f"Received signal {signum}, initiating shutdown...")
        self.__cdc_is_running = False


    def __load_kafka_producer(self):
        """Setup Kafka producer"""
        try:
            self.__kafka_producer = KafkaProducer(
                bootstrap_servers=self.__kaf_my_config["kafka"]["bootstrap_servers"],
                value_serializer=lambda v: json.dumps(v, default=str).encode("utf-8"),
                key_serializer=lambda k: str(k).encode("utf-8") if k else None,
                acks="all",
                retries=3,
                compression_type=None,
                batch_size=16384,
                linger_ms=10
            )
            logger.info("Kafka producer initialized successfully")
        except Exception as e:
            die(f"Failed to initialize Kafka producer: {e}")
            raise


    def __load_pymysql(self):
        """Setup MySQL connection"""
        try:
            mysql_config = self.__kaf_my_config["mysql"]
            self.__pymysql = pymysql.connect(
                host=mysql_config["host"],
                port=mysql_config["port"],
                database=mysql_config["database"],
                user=mysql_config["user"],
                password=mysql_config["password"],
                charset="utf8mb4",
                autocommit=True
            )
            logger.info(f"MySQL connection established to {mysql_config['host']}:{mysql_config['port']}")
        except Exception as e:
            die(f"Failed to connect to MySQL: {e}")
            raise


    def __send_to_kafka(
        self,
        topic: str,
        key: str,
        message: Dict[str, Any]
    ) -> None:
        """Send message to Kafka"""
        try:
            future = self.__kafka_producer.send(topic, key=key, value=message)
            record_metadata = future.get(timeout=10)
            logger.debug(f"Message sent to {record_metadata.topic} partition {record_metadata.partition}")
        except Exception as e:
            logger.error(f"Failed to send message to Kafka: {e}")


    def __create_change_event(
        self,
        table: str,
        operation: str,
        data: Dict[str, Any],
        old_data: Optional[Dict[str, Any]] = None
    ) -> Dict[str, Any]:
        """Create standardized change event"""
        return {
            "event_id": str(uuid.uuid4()),
            "timestamp": datetime.now(timezone.utc).isoformat(),
            "source": "mysql-cdc-worker",
            "database": self.__kaf_my_config["mysql"]["database"],
            "table": table,
            "operation": operation,  # INSERT, UPDATE, DELETE
            "data": data,
            "old_data": old_data,
            "version": "1.0"
        }


    def __start_binlog_monitoring(self) -> None:
        """Start MySQL binlog-based CDC monitoring"""
        try:
            mysql_config = self.__kaf_my_config["mysql"]

            self.__binlog_stream = BinLogStreamReader(
                connection_settings={
                    "host": mysql_config["host"],
                    "port": mysql_config["port"],
                    "user": mysql_config["user"],
                    "passwd": mysql_config["password"]
                },
                server_id=mysql_config.get("server_id", 100),
                only_events=[DeleteRowsEvent, WriteRowsEvent, UpdateRowsEvent],
                only_schemas=[mysql_config["database"]],
                only_tables=self.__kaf_my_config.get("tables_to_monitor", []),
                resume_stream=True,
                blocking=True
            )

            logger.info("Starting MySQL binlog monitoring...")

            for binlog_event in self.__binlog_stream:
                if not self.__cdc_is_running:
                    break

                self.__process_binlog_event(binlog_event)

        except Exception as e:
            err(f"Binlog monitoring error: {e}")
            self.__start_polling_monitoring()
        finally:
            if self.__binlog_stream:
                self.__binlog_stream.close()


    def __process_binlog_event(self, binlog_event):
        """Process binlog event and send to Kafka"""
        table_name = binlog_event.table

        if self.__kaf_my_config.get("tables_to_monitor") and table_name not in self.__kaf_my_config["tables_to_monitor"]:
            return

        kafka_topic = f"mysql.cdc.{table_name}"

        if isinstance(binlog_event, WriteRowsEvent):
            # INSERT
            for row in binlog_event.rows:
                event = self.__create_change_event(table_name, "INSERT", row["values"])
                kafka_key = self.__get_primary_key(table_name, row["values"])
                self.__send_to_kafka(kafka_topic, kafka_key, event)
                logger.info(f"INSERT event sent for table {table_name}")

        elif isinstance(binlog_event, UpdateRowsEvent):
            # UPDATE
            for row in binlog_event.rows:
                event = self.__create_change_event(
                    table_name, "UPDATE",
                    row["after_values"],
                    row["before_values"]
                )
                kafka_key = self.__get_primary_key(table_name, row["after_values"])
                self.__send_to_kafka(kafka_topic, kafka_key, event)
                logger.info(f"UPDATE event sent for table {table_name}")

        elif isinstance(binlog_event, DeleteRowsEvent):
            # DELETE
            for row in binlog_event.rows:
                event = self.__create_change_event(table_name, "DELETE", row["values"])
                kafka_key = self.__get_primary_key(table_name, row["values"])
                self.__send_to_kafka(kafka_topic, kafka_key, event)
                logger.info(f"DELETE event sent for table {table_name}")


    def __start_polling_monitoring(self):
        """Start polling-based CDC monitoring"""
        logger.info("Starting MySQL polling monitoring...")

        tables_config = self.__kaf_my_config.get('tables_to_monitor', {})
        if isinstance(tables_config, list):
            tables_config = {table: "updated_at" for table in tables_config}

        last_timestamps = {}

        while self.__cdc_is_running:
            try:
                for table_name, timestamp_column in tables_config.items():
                    self.__poll_table_changes(
                        table_name,
                        timestamp_column,
                        last_timestamps
                    )

                time.sleep(self.__kaf_my_config.get("polling_interval", 30))

            except Exception as e:
                err(f"Polling monitoring error: {e}")
                time.sleep(5)


    def __poll_table_changes(
        self,
        table_name: str,
        timestamp_column: str,
        last_timestamps: Dict[str, Any]
    ) -> None:
        """Poll a specific table for changes"""
        try:
            # pprint(pymysql.cursors.DictCursor)
            with self.__pymysql.cursor(pymysql.cursors.DictCursor) as cursor:
                last_timestamp = last_timestamps.get(table_name)
                if last_timestamp:
                    query = f"""
                    SELECT * 
                    FROM {table_name} 
                    WHERE {timestamp_column} > %s 
                    ORDER BY {timestamp_column}
                    """
                    cursor.execute(query, (last_timestamp,))
                else:
                    # First run - get recent records (last 1 minute)
                    query = f"""
                    SELECT * 
                    FROM {table_name} 
                    WHERE {timestamp_column} > DATE_SUB(NOW(), INTERVAL 1 MINUTE)
                    ORDER BY {timestamp_column}
                    """
                    cursor.execute(query)

                rows = cursor.fetchall()

                for row in rows:
                    # Send to Kafka
                    event = self.__create_change_event(table_name, "UPSERT", dict(row))
                    topic = f"mysql.cdc.{table_name}"
                    key = self.__get_primary_key(table_name, dict(row))

                    if self.__send_to_kafka(topic, key, event):
                        # Update last timestamp
                        current_timestamp = row.get(timestamp_column)
                        if current_timestamp:
                            last_timestamps[table_name] = current_timestamp

                if rows:
                    logger.info(f"Processed {len(rows)} changes from table {table_name}")

        except Exception as e:
            err(f"Error polling table {table_name}: {e}")


    def __get_primary_key(self, table_name: str, row_data: Dict[str, Any]) -> str:
        """Extract primary key from row data"""
        # Try common primary key column names
        pk_candidates = ["id", "user_id", "primary_key", f"{table_name}_id"]

        for pk_col in pk_candidates:
            if pk_col in row_data and row_data[pk_col] is not None:
                return str(row_data[pk_col])

        # If no obvious PK, use first column with a value
        for col, value in row_data.items():
            if value is not None:
                return str(value)

        return str(hash(str(row_data)))


    def start(self) -> None:
        """Start CDC monitoring"""
        logger.info("Starting MySQL CDC Worker...")

        try:
            # Try binlog monitoring first
            if self.__kaf_my_config.get("use_binlog", True):
                logger.info("Attempting binlog-based monitoring...")
                self.__start_binlog_monitoring()
            else:
                logger.info("Using polling-based monitoring...")
                self.__start_polling_monitoring()

        except KeyboardInterrupt:
            logger.info("Shutdown requested by user")
        except Exception as e:
            die(f"CDC Worker error: {e}")
        finally:
            self.stop()


    def stop(self) -> None:
        """Stop CDC monitoring and cleanup resources"""
        logger.info("Stopping MySQL CDC Worker...")
        self.__cdc_is_running = False
        
        if self.__binlog_stream:
            self.__binlog_stream.close()
        
        if self.__pymysql:
            self.__pymysql.close()
        
        if self.__kafka_producer:
            self.__kafka_producer.flush()
            self.__kafka_producer.close()
        
        logger.info("MySQL CDC Worker stopped")


