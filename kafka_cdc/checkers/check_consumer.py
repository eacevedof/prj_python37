# python -m checkers.check_consumer

import logging
from pprint import pprint

from kafka import KafkaConsumer
from config.kafka_config import KAFKAS

logging.basicConfig(level=logging.INFO)

def ___get_kafka_consumer() -> KafkaConsumer:
    kafka_host = KAFKAS.get("kafka-1").get("host")
    kafka_port = KAFKAS.get("kafka-1").get("port")
    kafka_socket = f"{kafka_host}:{kafka_port}"

    print(f"connecting to kafka at {kafka_socket}")
    return KafkaConsumer(
        "test",
        bootstrap_servers=[kafka_socket],
        auto_offset_reset="earliest",
        fetch_min_bytes=100,
        fetch_max_wait_ms=60000, # 1 min si la carga del mensaje no llega 100 bytes
        request_timeout_ms=70000,
         # enable_auto_commit=True,
         # group_id="test-consumer-group",
         # group_id=None,
         # fetch_max_wait_ms=0,
         # consumer_timeout_ms=10000,
         # value_deserializer=lambda x: loads(x.decode("utf-8"))
    )

"""
Ejemplo de consumer_record:
ConsumerRecord(
    topic='test', 
    partition=0, 
    offset=49, 
    timestamp=1623870315423, 
    timestamp_type=0, 
    key=None, 
    value=b'Message example:60ca4b6b67655 - message (2021-06-16 19:05:15)', 
    headers=[], 
    checksum=None, 
    serialized_key_size=-1, 
    serialized_value_size=61, 
    serialized_header_size=-1
)
"""

print(__name__)
if __name__ == "__main__":
    print("check_consumer running\n")

    kafka_consumer = ___get_kafka_consumer()
    for consumer_record in kafka_consumer:
        pprint(consumer_record)
        message = str(consumer_record.value.decode("utf-8"))
        print(message)


