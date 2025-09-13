#!/usr/bin/env python3
import json
import signal
import sys
import logging

from kafka import KafkaConsumer
from kafka.errors import KafkaError

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class StandardKafkaConsumer:
    """
    Standard Kafka Consumer following Apache Kafka best practices
    Supports multiple topics and consumer groups
    """
    
    def __init__(self, topics, consumer_group, bootstrap_servers='localhost:9092'):
        self.consumer = KafkaConsumer(
            *topics,
            bootstrap_servers=bootstrap_servers,
            group_id=consumer_group,
            
            # Deserialization
            value_deserializer=lambda m: json.loads(m.decode('utf-8')) if m else None,
            key_deserializer=lambda k: k.decode('utf-8') if k else None,
            
            # Consumer behavior
            auto_offset_reset='earliest',  # Start from beginning if no offset
            enable_auto_commit=False,      # Manual commit for reliability
            max_poll_records=100,          # Process in batches
            
            # Session management
            session_timeout_ms=30000,
            heartbeat_interval_ms=3000,
            
            # Performance
            fetch_min_bytes=1,
            fetch_max_wait_ms=500
        )
        
        self.running = True
        
        # Setup graceful shutdown
        signal.signal(signal.SIGINT, self._shutdown_handler)
        signal.signal(signal.SIGTERM, self._shutdown_handler)
    
    def _shutdown_handler(self, signum, frame):
        """Handle graceful shutdown"""
        logger.info(f"Received signal {signum}, initiating shutdown...")
        self.running = False
    
    def consume_messages(self, message_handlers=None):
        """
        Consume messages with topic-specific handlers
        message_handlers: dict mapping topic patterns to handler functions
        """
        message_handlers = message_handlers or {}
        
        try:
            logger.info(f"Starting consumer for topics: {self.consumer.subscription()}")
            
            while self.running:
                # Poll for messages
                message_batch = self.consumer.poll(timeout_ms=1000)
                
                if not message_batch:
                    continue
                
                # Process messages by topic partition
                for topic_partition, messages in message_batch.items():
                    topic = topic_partition.topic
                    
                    for message in messages:
                        try:
                            # Find appropriate handler
                            handler = self._find_handler(topic, message_handlers)
                            if handler:
                                handler(message)
                            else:
                                self._default_handler(message)
                                
                        except Exception as e:
                            logger.error(f"Error processing message from {topic}: {e}")
                            # Continue processing other messages
                
                # Commit offsets after successful processing
                try:
                    self.consumer.commit()
                except KafkaError as e:
                    logger.error(f"Failed to commit offsets: {e}")
                    
        except Exception as e:
            logger.error(f"Consumer error: {e}")
            raise
        finally:
            self.consumer.close()
            logger.info("Consumer closed")
    
    def _find_handler(self, topic, handlers):
        """Find the appropriate handler for a topic"""
        # Exact match first
        if topic in handlers:
            return handlers[topic]
        
        # Pattern matching
        for pattern, handler in handlers.items():
            if pattern.replace('*', '') in topic:
                return handler
        
        return None
    
    def _default_handler(self, message):
        """Default message handler"""
        logger.info(f"Topic: {message.topic}, Partition: {message.partition}, "
                   f"Offset: {message.offset}, Key: {message.key}")
        logger.info(f"Message: {message.value}")

class SecurityEventConsumer(StandardKafkaConsumer):
    """Specialized consumer for security events"""
    
    def __init__(self, bootstrap_servers='localhost:9092'):
        topics = [
            'security.user.login',
            'security.user.password_change',
            'security.alert.suspicious_login',
            'security.alert.malware_detected'
        ]
        super().__init__(topics, 'security-event-processors', bootstrap_servers)
    
    def handle_user_login(self, message):
        """Handle user login events"""
        data = message.value
        logger.info(f"Processing login for user {data.get('user_id')} from IP {data.get('data', {}).get('ip_address')}")
        
        # Example security processing
        ip_address = data.get('data', {}).get('ip_address')
        if ip_address and ip_address.startswith('10.0.0.'):
            logger.warning(f"Login from suspicious IP range: {ip_address}")
    
    def handle_password_change(self, message):
        """Handle password change events"""
        data = message.value
        logger.info(f"Password changed for user {data.get('user_id')}")
        
        # Example: Log security event
        logger.info("Password change logged for compliance")
    
    def handle_security_alert(self, message):
        """Handle security alerts"""
        data = message.value
        alert_type = data.get('alert_type')
        severity = data.get('severity')
        
        logger.warning(f"Security Alert [{severity}]: {alert_type}")
        
        if severity == 'CRITICAL':
            logger.critical(f"CRITICAL ALERT: {data.get('data')}")
            # Example: Send to SIEM, trigger incident response
    
    def start_consuming(self):
        """Start consuming with security-specific handlers"""
        handlers = {
            'security.user.login': self.handle_user_login,
            'security.user.password_change': self.handle_password_change,
            'security.alert.*': self.handle_security_alert
        }
        
        self.consume_messages(handlers)

class MonitoringConsumer(StandardKafkaConsumer):
    """Specialized consumer for monitoring metrics"""
    
    def __init__(self, bootstrap_servers='localhost:9092'):
        topics = ['monitoring.metrics.collected']
        super().__init__(topics, 'monitoring-processors', bootstrap_servers)
    
    def handle_metrics(self, message):
        """Handle monitoring metrics"""
        data = message.value
        metric_name = data.get('metric_name')
        metric_value = data.get('value')
        tags = data.get('tags', {})
        
        logger.info(f"Metric: {metric_name} = {metric_value} {tags}")
        
        # Example processing
        if metric_name == 'cpu_usage_percent' and metric_value > 90:
            logger.warning(f"High CPU usage detected: {metric_value}% on {tags.get('host')}")
        
        if metric_name == 'memory_usage_bytes' and metric_value > 1073741824:  # 1GB
            logger.warning(f"High memory usage detected: {metric_value} bytes on {tags.get('host')}")
    
    def start_consuming(self):
        """Start consuming with monitoring-specific handlers"""
        handlers = {
            'monitoring.metrics.collected': self.handle_metrics
        }
        
        self.consume_messages(handlers)

def main():
    """Example usage of Kafka consumers"""
    import threading
    import time
    
    # Start security event consumer in thread
    def start_security_consumer():
        consumer = SecurityEventConsumer()
        consumer.start_consuming()
    
    # Start monitoring consumer in thread
    def start_monitoring_consumer():
        consumer = MonitoringConsumer()
        consumer.start_consuming()
    
    # Generic consumer for all topics
    def start_generic_consumer():
        topics = [
            'security.user.login',
            'security.user.password_change', 
            'security.alert.suspicious_login',
            'security.alert.malware_detected',
            'monitoring.metrics.collected'
        ]
        consumer = StandardKafkaConsumer(topics, 'generic-processors')
        consumer.consume_messages()
    
    print("Choose consumer type:")
    print("1. Security Event Consumer")
    print("2. Monitoring Consumer") 
    print("3. Generic Consumer (all topics)")
    print("4. All consumers (threaded)")
    
    choice = input("Enter choice (1-4): ").strip()
    
    try:
        if choice == '1':
            start_security_consumer()
        elif choice == '2':
            start_monitoring_consumer()
        elif choice == '3':
            start_generic_consumer()
        elif choice == '4':
            # Start all consumers in separate threads
            threads = [
                threading.Thread(target=start_security_consumer, daemon=True),
                threading.Thread(target=start_monitoring_consumer, daemon=True)
            ]
            
            for thread in threads:
                thread.start()
            
            logger.info("All consumers started. Press Ctrl+C to stop.")
            
            # Keep main thread alive
            try:
                while True:
                    time.sleep(1)
            except KeyboardInterrupt:
                logger.info("Shutting down all consumers...")
                
        else:
            print("Invalid choice")
            
    except KeyboardInterrupt:
        logger.info("Consumer interrupted by user")
    except Exception as e:
        logger.error(f"Consumer error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()