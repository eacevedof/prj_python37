import json
import time
import uuid
import signal

from datetime import datetime, timezone
from typing import Dict, Any, Optional
from typing import final

import pymysql
from pymysqlreplication import BinLogStreamReader
from pymysqlreplication.row_event import (
    DeleteRowsEvent,
    UpdateRowsEvent,
    WriteRowsEvent,
)

from kafka import KafkaProducer

from config import die, err, logger

@final
class MySqlCDCProducer:
    """
    MySQL Change Data Capture Worker
    Monitors MySQL database changes and publishes them to Kafka
    """
    
    def __init__(
        self,
        mysql_config: Dict[str, Any],
        kafka_config: Dict[str, Any]
    ):
        self.__mysql_config = mysql_config
        self.__kafka_config = kafka_config
        self.__cdc_is_running = True
        self.__pymysql = None
        self.__binlog_stream = None
        self.__kafka_producer = None

        # detecta el ctrl + c
        signal.signal(signal.SIGINT, self.__shutdown_listener)
        signal.signal(signal.SIGTERM, self.__shutdown_listener)
        
        self.__load_pymysql()
        self.__load_kafka_producer()


    @staticmethod
    def get_instance(
        mysql_config: Dict[str, Any],
        kafka_config: Dict[str, Any]
    ) -> "MySqlCDCProducer":
        """Factory method to create MySqlCDCProducer instance"""
        return MySqlCDCProducer(mysql_config, kafka_config)


    def __shutdown_listener(self, signum, frame) -> None:
        """Handle graceful shutdown"""
        logger.info(f"Received signal {signum}, initiating shutdown...")
        self.__cdc_is_running = False


    def __load_kafka_producer(self) -> None:
        """Setup Kafka producer"""
        try:
            self.__kafka_producer = KafkaProducer(
                bootstrap_servers = f"{self.__kafka_config["host"]}:{self.__kafka_config["port"]}",
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
            raise e


    def __load_pymysql(self) -> None:
        """Setup MySQL connection"""
        try:
            mysql_config = self.__mysql_config
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
            raise e


    def __send_to_kafka(
        self,
        kafka_topic: str,
        message_key: str,
        message: Dict[str, Any]
    ) -> None:
        """Send message to Kafka"""
        try:
            future = self.__kafka_producer.send(
                kafka_topic,
                key=message_key,
                value=message
            )
            record_metadata = future.get(timeout=10)
            logger.debug(f"Message sent to {record_metadata.topic} partition {record_metadata.partition}")
        except Exception as e:
            logger.error(f"Failed to send message to Kafka: {e}")


    def __create_change_event(
        self,
        table_name: str,
        cud_operation: str,
        new_data: Dict[str, Any],
        old_data: Optional[Dict[str, Any]] = None
    ) -> Dict[str, Any]:
        """Create standardized change event"""
        return {
            "event_id": str(uuid.uuid4()),
            "timestamp": datetime.now(timezone.utc).isoformat(),
            "source": "mysql-cdc-producer",
            "database": self.__mysql_config["database"],
            "table": table_name,
            "operation": cud_operation,  # INSERT, UPDATE, DELETE
            "data": new_data,
            "old_data": old_data,
            "version": "1.0"
        }


    def __start_binlog_monitoring(self) -> None:
        """Start MySQL binlog-based CDC monitoring"""
        try:
            mysql_config = self.__mysql_config

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
                only_tables=self.__mysql_config.get("tables_to_monitor", []),
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


    def __process_binlog_event(self, binlog_event: object) -> None:
        """Process binlog event and send to Kafka"""
        table_name = binlog_event.table

        if self.__mysql_config.get("tables_to_monitor") and table_name not in self.__mysql_config["tables_to_monitor"]:
            return

        kafka_topic = self.__mysql_config.get("kafka").get("topic")

        if isinstance(binlog_event, WriteRowsEvent):
            # INSERT
            for row_insert in binlog_event.rows:
                kafka_key = self.__get_primary_key(table_name, row_insert["values"])
                insert_event = self.__create_change_event(table_name, "INSERT", row_insert["values"])
                self.__send_to_kafka(kafka_topic, kafka_key, insert_event)
                logger.info(f"INSERT event sent for table {table_name}")

            return

        if isinstance(binlog_event, UpdateRowsEvent):
            for row_update in binlog_event.rows:
                update_event = self.__create_change_event(
                    table_name, "UPDATE",
                    row_update["after_values"],
                    row_update["before_values"]
                )
                kafka_key = self.__get_primary_key(table_name, row_update["after_values"])
                self.__send_to_kafka(kafka_topic, kafka_key, update_event)
                logger.info(f"UPDATE event sent for table {table_name}")
            return

        if isinstance(binlog_event, DeleteRowsEvent):
            # DELETE
            for row_delete in binlog_event.rows:
                delete_event = self.__create_change_event(table_name, "DELETE", row_delete["values"])
                kafka_key = self.__get_primary_key(table_name, row_delete["values"])
                self.__send_to_kafka(kafka_topic, kafka_key, delete_event)
                logger.info(f"DELETE event sent for table {table_name}")


    def __start_polling_monitoring(self) -> None:
        """Start polling-based CDC monitoring"""
        logger.info("Starting MySQL polling monitoring...")

        listen_tables = self.__mysql_config.get("tables_to_monitor", {})
        if isinstance(listen_tables, list):
            listen_tables = {table: "updated_at" for table in listen_tables}

        last_timestamps = {}

        while self.__cdc_is_running:
            try:
                for table_name, timestamp_column in listen_tables.items():
                    self.__listen_mysql_changes(
                        table_name,
                        timestamp_column,
                        last_timestamps
                    )

                time.sleep(self.__mysql_config.get("polling_interval", 30))

            except Exception as e:
                err(f"Polling monitoring error: {e}")
                time.sleep(5)


    def __listen_mysql_changes(
        self,
        table_name: str,
        timestamp_column: str,
        last_timestamps: Dict[str, Any]
    ) -> None:
        """Poll a specific table for changes"""
        try:
            with self.__pymysql.cursor(pymysql.cursors.DictCursor) as cursor:
                query = f"""
                SELECT * 
                FROM {table_name} 
                WHERE {timestamp_column} > DATE_SUB(NOW(), INTERVAL 1 MINUTE)
                ORDER BY {timestamp_column}
                """
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
                    cursor.execute(query)

                changed_rows = cursor.fetchall()
                if not changed_rows:
                    return

                for changed_row in changed_rows:
                    kafka_topic = self.__mysql_config.get("kafka").get("topic")
                    kafka_key = self.__get_primary_key(table_name, dict(changed_row))
                    upsert_event = self.__create_change_event(table_name, "UPSERT", dict(changed_row))

                    if self.__send_to_kafka(kafka_topic, kafka_key, upsert_event):
                        current_timestamp = changed_row.get(timestamp_column)
                        if current_timestamp:
                            last_timestamps[table_name] = current_timestamp

                logger.info(f"Processed {len(changed_rows)} changes from table {table_name}")

        except Exception as e:
            err(f"Error polling table {table_name}: {e}")


    @staticmethod
    def __get_primary_key(table_name: str, row_data: Dict[str, Any]) -> str:
        """Extract primary key from row data"""
        pk_candidates = ["id", "user_id", "primary_key", f"{table_name}_id"]
        for pk_col in pk_candidates:
            if pk_col in row_data and row_data[pk_col] is not None:
                return str(row_data[pk_col])

        for col, value in row_data.items():
            if value is not None:
                return str(value)

        return str(hash(str(row_data)))


    def start(self) -> None:
        """Start CDC monitoring"""
        logger.info("Starting MySQL CDC Worker...")

        try:
            # Try binlog monitoring first
            if self.__mysql_config.get("use_binlog", True):
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


