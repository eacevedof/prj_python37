# python -m checkers.check_producer

from time import sleep
from json import dumps

from kafka import KafkaProducer
from config.kafka_config import KAFKAS


def ___get_kafka_producer() -> KafkaProducer:
    kafka_host = KAFKAS.get("kafka-1").get("host")
    kafka_port = KAFKAS.get("kafka-1").get("port")
    kafka_socket = f"{kafka_host}:{kafka_port}"

    print(f"connecting to kafka at {kafka_socket}")
    return KafkaProducer(
        bootstrap_servers=[kafka_socket],
        value_serializer=lambda x: dumps(x).encode("utf-8")
    )


if __name__ == "__main__":
    print("check_producer running\n")
    kafka_producer = ___get_kafka_producer()
    for e in range(15):
        data = {"produced_number": e}
        kafka_producer.send("test", value=data)
        print(f"sent: {data}")
        sleep(5)
