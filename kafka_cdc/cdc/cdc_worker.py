# python -m cdc.cdc_worker

from . import die
from typing import Dict, List, Optional, Any

from config.mysql_config import MYSQLS
from config.kafka_config import KAFKAS
from .mysql_cdc_worker import MySQLCDCWorker

def __get_kafka_and_mysql_config() -> Dict[str, Any]:
    """Load configuration"""
    mysql_config = MYSQLS.get("my-1")

    kafka_config = KAFKAS.get("kafka-1")
    kafka_socket = f"{kafka_config.get("host")}:{kafka_config.get("port")}"
    return {
        "mysql": {
            "host": mysql_config.get("host"),
            "port": mysql_config.get("port"),
            "database": mysql_config.get("database"),
            "user": mysql_config.get("user"),
            "password": mysql_config.get("password"),
            "server_id": mysql_config.get("id")
        },
        "kafka": {
            "bootstrap_servers": [kafka_socket]
        },
        "tables_to_monitor": mysql_config.get("tables_to_monitor", {}),
        "use_binlog": mysql_config.get("use_binlog"),
        "polling_interval": mysql_config.get("polling_interval"),
    }


def __run_worker() -> None:
    """Main function"""
    kafka_and_mysql_config = __get_kafka_and_mysql_config()
    mysql_config = kafka_and_mysql_config.get("mysql", {})

    required_mysql_fields = ["host", "port", "user", "password", "database"]
    missing_fields = [field for field in required_mysql_fields if field not in mysql_config]
    if missing_fields:
        die(f"Missing required MySQL configuration fields: {missing_fields}")
        return

    cdc_worker = MySQLCDCWorker(kafka_and_mysql_config)

    try:
        cdc_worker.start()
    except Exception as e:
        die(f"Failed to start worker: {e}")
    finally:
        cdc_worker.stop()


if __name__ == "__main__":
    __run_worker()