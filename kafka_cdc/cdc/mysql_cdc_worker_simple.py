#!/usr/bin/env python3

import json
import time
import uuid
import signal
from datetime import datetime, timezone
from typing import Dict, Optional, Any
import logging

import pymysql
from kafka import KafkaProducer

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

class MySQLCDCWorker:
    """
    MySQL Change Data Capture Worker (Polling Mode Only)
    Monitors MySQL database changes and publishes them to Kafka
    """
    
    def __init__(self, config: Dict[str, Any]):
        self.config = config
        self.running = True
        self.producer = None
        self.mysql_connection = None
        
        # Setup graceful shutdown
        signal.signal(signal.SIGINT, self._shutdown_handler)
        signal.signal(signal.SIGTERM, self._shutdown_handler)
        
        self._setup_kafka_producer()
        self._setup_mysql_connection()
    
    def _shutdown_handler(self, signum, frame):
        """Handle graceful shutdown"""
        logger.info(f"Received signal {signum}, initiating shutdown...")
        self.running = False
    
    def _setup_kafka_producer(self):
        """Setup Kafka producer"""
        try:
            self.producer = KafkaProducer(
                bootstrap_servers=self.config['kafka']['bootstrap_servers'],
                value_serializer=lambda v: json.dumps(v, default=str).encode('utf-8'),
                key_serializer=lambda k: str(k).encode('utf-8') if k else None,
                acks='all',
                retries=3,
                compression_type=None,
                batch_size=16384,
                linger_ms=10
            )
            logger.info("Kafka producer initialized successfully")
        except Exception as e:
            logger.error(f"Failed to initialize Kafka producer: {e}")
            raise
    
    def _setup_mysql_connection(self):
        """Setup MySQL connection"""
        try:
            mysql_config = self.config['mysql']
            self.mysql_connection = pymysql.connect(
                host=mysql_config['host'],
                port=mysql_config['port'],
                user=mysql_config['user'],
                password=mysql_config['password'],
                database=mysql_config['database'],
                charset='utf8mb4',
                autocommit=True
            )
            logger.info(f"MySQL connection established to {mysql_config['host']}:{mysql_config['port']}")
        except Exception as e:
            logger.error(f"Failed to connect to MySQL: {e}")
            raise
    
    def _send_to_kafka(self, topic: str, key: str, message: Dict[str, Any]):
        """Send message to Kafka"""
        try:
            future = self.producer.send(topic, key=key, value=message)
            record_metadata = future.get(timeout=10)
            logger.debug(f"Message sent to {record_metadata.topic} partition {record_metadata.partition}")
            return True
        except Exception as e:
            logger.error(f"Failed to send message to Kafka: {e}")
            return False
    
    def _create_change_event(self, table: str, operation: str, data: Dict[str, Any], 
                           old_data: Optional[Dict[str, Any]] = None) -> Dict[str, Any]:
        """Create standardized change event"""
        return {
            'event_id': str(uuid.uuid4()),
            'timestamp': datetime.now(timezone.utc).isoformat(),
            'source': 'mysql-cdc-worker',
            'database': self.config['mysql']['database'],
            'table': table,
            'operation': operation,  # INSERT, UPDATE, DELETE, UPSERT
            'data': data,
            'old_data': old_data,
            'version': '1.0'
        }
    
    def start_polling_monitoring(self):
        """Start polling-based CDC monitoring"""
        logger.info("Starting MySQL polling monitoring...")
        
        tables_config = self.config.get('tables_to_monitor', {})
        if isinstance(tables_config, list):
            # Convert list to dict with default timestamp column
            tables_config = {table: 'updated_at' for table in tables_config}
        
        # Store last seen timestamps for each table
        last_timestamps = {}
        
        while self.running:
            try:
                for table_name, timestamp_column in tables_config.items():
                    self._poll_table_changes(table_name, timestamp_column, last_timestamps)
                
                # Sleep between polling cycles
                time.sleep(self.config.get('polling_interval', 30))
                
            except Exception as e:
                logger.error(f"Polling monitoring error: {e}")
                time.sleep(5)
    
    def _poll_table_changes(self, table_name: str, timestamp_column: str, last_timestamps: Dict[str, Any]):
        """Poll a specific table for changes"""
        try:
            with self.mysql_connection.cursor(pymysql.cursors.DictCursor) as cursor:
                # Check if table exists
                cursor.execute("SHOW TABLES LIKE %s", (table_name,))
                if not cursor.fetchone():
                    logger.warning(f"Table {table_name} does not exist, skipping...")
                    return
                
                # Check if timestamp column exists
                cursor.execute(f"SHOW COLUMNS FROM {table_name} LIKE %s", (timestamp_column,))
                if not cursor.fetchone():
                    logger.warning(f"Column {timestamp_column} does not exist in table {table_name}, skipping...")
                    return
                
                # Get last timestamp for this table
                last_timestamp = last_timestamps.get(table_name)
                
                if last_timestamp:
                    query = f"""
                    SELECT * FROM {table_name} 
                    WHERE {timestamp_column} > %s 
                    ORDER BY {timestamp_column}
                    LIMIT 1000
                    """
                    cursor.execute(query, (last_timestamp,))
                else:
                    # First run - get recent records (last 5 minutes)
                    query = f"""
                    SELECT * FROM {table_name} 
                    WHERE {timestamp_column} > DATE_SUB(NOW(), INTERVAL 5 MINUTE)
                    ORDER BY {timestamp_column}
                    LIMIT 100
                    """
                    cursor.execute(query)
                
                rows = cursor.fetchall()
                
                for row in rows:
                    # Send to Kafka
                    event = self._create_change_event(table_name, 'UPSERT', dict(row))
                    topic = f"mysql.cdc.{table_name}"
                    key = self._get_primary_key(table_name, dict(row))
                    
                    if self._send_to_kafka(topic, key, event):
                        # Update last timestamp
                        current_timestamp = row.get(timestamp_column)
                        if current_timestamp:
                            last_timestamps[table_name] = current_timestamp
                
                if rows:
                    logger.info(f"Processed {len(rows)} changes from table {table_name}")
                    
        except Exception as e:
            logger.error(f"Error polling table {table_name}: {e}")
    
    def _get_primary_key(self, table_name: str, row_data: Dict[str, Any]) -> str:
        """Extract primary key from row data"""
        # Try common primary key column names
        pk_candidates = ['id', 'user_id', 'primary_key', f'{table_name}_id']
        
        for pk_col in pk_candidates:
            if pk_col in row_data and row_data[pk_col] is not None:
                return str(row_data[pk_col])
        
        # If no obvious PK, use first column with a value
        for col, value in row_data.items():
            if value is not None:
                return str(value)
        
        # Fallback
        return str(hash(str(row_data)))
    
    def start(self):
        """Start CDC monitoring"""
        logger.info("Starting MySQL CDC Worker (Polling Mode)...")
        
        try:
            self.start_polling_monitoring()
                
        except KeyboardInterrupt:
            logger.info("Shutdown requested by user")
        except Exception as e:
            logger.error(f"CDC Worker error: {e}")
        finally:
            self.stop()
    
    def stop(self):
        """Stop CDC monitoring and cleanup resources"""
        logger.info("Stopping MySQL CDC Worker...")
        self.running = False
        
        if self.mysql_connection:
            self.mysql_connection.close()
        
        if self.producer:
            self.producer.flush()
            self.producer.close()
        
        logger.info("MySQL CDC Worker stopped")