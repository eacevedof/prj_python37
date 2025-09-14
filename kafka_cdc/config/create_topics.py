#!/usr/bin/env python3

from kafka.admin import KafkaAdminClient, NewTopic
from kafka.errors import TopicAlreadyExistsError
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def create_kafka_topics():
    """Create Kafka topics for MySQL CDC"""
    
    # Kafka admin client
    admin_client = KafkaAdminClient(
        bootstrap_servers=['localhost:9092'],
        client_id='topic_creator'
    )
    
    # Topics from mysql_config.py tables_to_monitor
    topics_to_create = [
        "mysql.cdc.users",
        "mysql.cdc.user_sessions", 
        "mysql.cdc.security_events",
        "mysql.cdc.audit_logs",
        "mysql.cdc.failed_logins"
    ]
    
    # Create NewTopic objects
    topic_list = []
    for topic_name in topics_to_create:
        topic = NewTopic(
            name=topic_name,
            num_partitions=3,
            replication_factor=1
        )
        topic_list.append(topic)
    
    try:
        # Create topics
        result = admin_client.create_topics(new_topics=topic_list, validate_only=False)
        
        # Check results
        for topic, future in result.items():
            try:
                future.result()  # The result itself is None
                logger.info(f"Topic '{topic}' created successfully")
            except TopicAlreadyExistsError:
                logger.info(f"Topic '{topic}' already exists")
            except Exception as e:
                logger.error(f"Failed to create topic '{topic}': {e}")
                
    except Exception as e:
        logger.error(f"Error creating topics: {e}")
    
    # List all topics
    try:
        from kafka import KafkaConsumer
        consumer = KafkaConsumer(bootstrap_servers=['localhost:9092'])
        topics = consumer.list_consumer_group_offsets()
        metadata = consumer.list_topics()
        
        logger.info("Current MySQL CDC topics:")
        for topic in sorted(metadata):
            if topic.startswith('mysql.cdc.'):
                logger.info(f"  ✓ {topic}")
        consumer.close()
    except Exception as e:
        logger.error(f"Error listing topics: {e}")
    
    admin_client.close()

if __name__ == "__main__":
    print("Creating Kafka topics for MySQL CDC...")
    create_kafka_topics()
    print("Done!")