# python -m cdc.cdc_worker

from typing import Dict, Any, Tuple

from config import die
from config.mysql_config import MYSQLS
from config.kafka_config import KAFKAS
from .mysql_cdc_producer import MySqlCDCProducer


def __get_separated_configs() -> Tuple[Dict[str, Any], Dict[str, Any]]:
    """Load and separate MySQL and Kafka configurations"""
    mysql_config = MYSQLS.get("my-1")
    if not mysql_config:
        die("MySQL configuration \"my-1\" not found")
        return {}, {}

    kafka_config = KAFKAS.get("kafka-1")
    if not kafka_config:
        die("Kafka configuration \"kafka-1\" not found")
        return {}, {}

    return mysql_config, kafka_config


def __die_if_wrong_mysql_config(mysql_config: Dict[str, Any]) -> None:
    """Validate MySQL configuration"""
    required_mysql_fields = ["host", "port", "user", "password", "database"]
    missing_fields = [field for field in required_mysql_fields if field not in mysql_config]
    if missing_fields:
        die(f"Missing required MySQL configuration fields: {missing_fields}")


def __run_cdc_worker() -> None:
    """Main function"""

    mysql_cdc_producer = None
    try:
        mysql_config, kafka_config = __get_separated_configs()

        __die_if_wrong_mysql_config(mysql_config)

        mysql_cdc_producer = MySqlCDCProducer.get_instance(
            mysql_config,
            kafka_config
        )
        mysql_cdc_producer.start()
    except Exception as e:
        die(f"Failed to start worker: {e}")
    finally:
        if isinstance(mysql_cdc_producer, object):
            mysql_cdc_producer.stop()


if __name__ == "__main__":
    __run_cdc_worker()