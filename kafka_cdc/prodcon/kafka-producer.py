#!/usr/bin/env python3

import json
import time
import uuid
from datetime import datetime
from kafka import KafkaProducer
from kafka.errors import KafkaError
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class StandardKafkaProducer:
    """
    Standard Kafka Producer following Apache Kafka best practices
    Topic naming convention: <domain>.<entity>.<event-type>
    """
    
    def __init__(self, bootstrap_servers='localhost:9092'):
        self.producer = KafkaProducer(
            bootstrap_servers=bootstrap_servers,
            # Serialization
            value_serializer=lambda v: json.dumps(v).encode('utf-8'),
            key_serializer=lambda k: str(k).encode('utf-8') if k else None,
            
            # Reliability settings
            acks='all',  # Wait for all replicas
            retries=3,
            max_in_flight_requests_per_connection=1,
            
            # Performance settings
            batch_size=16384,
            linger_ms=10,
            buffer_memory=33554432,
            
            # Compression (disabled for compatibility)
            compression_type=None
        )
        
    def send_user_event(self, user_id, event_type, event_data):
        """Send user domain events"""
        topic = f"security.user.{event_type}"
        
        message = {
            'event_id': str(uuid.uuid4()),
            'timestamp': datetime.utcnow().isoformat(),
            'user_id': user_id,
            'event_type': event_type,
            'data': event_data,
            'source': 'user-service',
            'version': '1.0'
        }
        
        try:
            future = self.producer.send(
                topic=topic,
                key=user_id,
                value=message,
                partition=None  # Use default partitioner based on key
            )
            
            # Block for synchronous send (optional)
            record_metadata = future.get(timeout=10)
            logger.info(f"Message sent to {record_metadata.topic} partition {record_metadata.partition} offset {record_metadata.offset}")
            
        except KafkaError as e:
            logger.error(f"Failed to send message: {e}")
            raise
    
    def send_security_alert(self, alert_type, severity, alert_data):
        """Send security domain alerts"""
        topic = f"security.alert.{alert_type}"
        
        message = {
            'alert_id': str(uuid.uuid4()),
            'timestamp': datetime.utcnow().isoformat(),
            'alert_type': alert_type,
            'severity': severity,
            'data': alert_data,
            'source': 'security-service',
            'version': '1.0'
        }
        
        try:
            # Use alert_type as key for consistent partitioning
            future = self.producer.send(
                topic=topic,
                key=alert_type,
                value=message
            )
            
            record_metadata = future.get(timeout=10)
            logger.info(f"Alert sent to {record_metadata.topic} partition {record_metadata.partition}")
            
        except KafkaError as e:
            logger.error(f"Failed to send alert: {e}")
            raise
    
    def send_monitoring_metric(self, metric_name, metric_value, tags=None):
        """Send monitoring domain metrics"""
        topic = "monitoring.metrics.collected"
        
        message = {
            'metric_id': str(uuid.uuid4()),
            'timestamp': datetime.utcnow().isoformat(),
            'metric_name': metric_name,
            'value': metric_value,
            'tags': tags or {},
            'source': 'monitoring-service',
            'version': '1.0'
        }
        
        try:
            future = self.producer.send(
                topic=topic,
                key=metric_name,
                value=message
            )
            
            record_metadata = future.get(timeout=10)
            logger.info(f"Metric sent to {record_metadata.topic} partition {record_metadata.partition}")
            
        except KafkaError as e:
            logger.error(f"Failed to send metric: {e}")
            raise
    
    def close(self):
        """Close producer and flush remaining messages"""
        self.producer.flush()
        self.producer.close()

def main():
    """Example usage of the Kafka producer"""
    producer = StandardKafkaProducer()
    
    try:
        # Send user events
        producer.send_user_event(
            user_id="user_123",
            event_type="login",
            event_data={
                "ip_address": "192.168.1.100",
                "user_agent": "Mozilla/5.0...",
                "session_id": "sess_456"
            }
        )
        
        producer.send_user_event(
            user_id="user_456",
            event_type="password_change",
            event_data={
                "ip_address": "192.168.1.101",
                "previous_password_hash": "old_hash"
            }
        )
        
        # Send security alerts
        producer.send_security_alert(
            alert_type="suspicious_login",
            severity="HIGH",
            alert_data={
                "user_id": "user_789",
                "failed_attempts": 5,
                "ip_address": "10.0.0.1",
                "location": "Unknown"
            }
        )
        
        producer.send_security_alert(
            alert_type="malware_detected",
            severity="CRITICAL",
            alert_data={
                "file_hash": "abc123def456",
                "file_path": "/tmp/suspicious.exe",
                "detection_engine": "ClamAV"
            }
        )
        
        # Send monitoring metrics
        producer.send_monitoring_metric(
            metric_name="cpu_usage_percent",
            metric_value=75.5,
            tags={"host": "web-server-01", "environment": "production"}
        )
        
        producer.send_monitoring_metric(
            metric_name="memory_usage_bytes",
            metric_value=2147483648,
            tags={"host": "db-server-01", "environment": "production"}
        )
        
        logger.info("All messages sent successfully")
        
    except Exception as e:
        logger.error(f"Error in main: {e}")
        raise
    finally:
        producer.close()

if __name__ == "__main__":
    main()