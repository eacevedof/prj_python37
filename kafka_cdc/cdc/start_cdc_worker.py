# python -m cdc.start_cdc_worker

# https://www.facebook.com/reel/1113590254242384 instalable

import json
import sys
import os
from .mysql_cdc_worker_simple import MySQLCDCWorker
import logging

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

def load_config_from_file(config_path: str = 'mysql-cdc-config.json'):
    """Load configuration from JSON file"""
    if os.path.exists(config_path):
        with open(config_path, 'r') as f:
            return json.load(f)
    else:
        logger.error(f"Configuration file {config_path} not found")
        return None

def load_default_config():
    """Load default configuration for your Docker environment"""
    return {
        'mysql': {
            'host': 'localhost',
            'port': 3306,
            'user': 'root',
            'password': 'root',
            'database': 'db_kafka_cdc',
            'server_id': 100
        },
        'kafka': {
            'bootstrap_servers': ['localhost:9092']
        },
        'tables_to_monitor': {
            'users': 'updated_at',
            'user_sessions': 'created_at',
            'security_events': 'timestamp',
            'audit_logs': 'created_at',
            'failed_logins': 'attempt_time'
        },
        'use_binlog': False,  # Start with polling mode
        'polling_interval': 10,  # Check every 10 seconds for testing
        'topic_prefix': 'mysql.cdc'
    }



def main():
    """Main function to start CDC worker"""
    
    # Load configuration
    config = load_config_from_file()
    if not config:
        logger.info("Using default configuration")
        config = load_default_config()
    
    logger.info("Configuration loaded:")
    logger.info(f"MySQL: {config['mysql']['host']}:{config['mysql']['port']}/{config['mysql']['database']}")
    logger.info(f"Kafka: {config['kafka']['bootstrap_servers']}")
    logger.info(f"Tables to monitor: {list(config['tables_to_monitor'].keys())}")
    logger.info(f"Monitoring mode: {'Binlog' if config.get('use_binlog') else 'Polling'}")
    
    # Test connections
    logger.info("Testing MySQL connection...")
    if not test_mysql_connection(config):
        logger.error("Cannot proceed without MySQL connection")
        sys.exit(1)
    
    # Test Kafka connection
    logger.info("Testing Kafka connection...")
    try:
        from kafka import KafkaProducer
        producer = KafkaProducer(
            bootstrap_servers=config['kafka']['bootstrap_servers'],
            request_timeout_ms=5000
        )
        producer.close()
        logger.info("Kafka connection successful")
    except Exception as e:
        logger.error(f"Kafka connection failed: {e}")
        logger.error("Make sure Kafka is running on localhost:9092")
        sys.exit(1)
    
    # Start CDC Worker
    logger.info("Starting MySQL CDC Worker...")
    worker = MySQLCDCWorker(config)
    
    try:
        worker.start()
    except KeyboardInterrupt:
        logger.info("Shutdown requested by user")
    except Exception as e:
        logger.error(f"Worker failed: {e}")
    finally:
        worker.stop()

if __name__ == "__main__":
    print("MySQL Change Data Capture (CDC) Worker")
    print("=====================================")
    print()
    print("This worker monitors MySQL database changes and publishes them to Kafka.")
    print()
    print("Prerequisites:")
    print("1. MySQL server running on localhost:3306")
    print("2. Kafka server running on localhost:9092") 
    print("3. Test database created (run test-mysql-setup.sql)")
    print()
    print("Press Ctrl+C to stop the worker")
    print()
    
    main()