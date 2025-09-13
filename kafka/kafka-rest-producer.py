#!/usr/bin/env python3

import json
import uuid
from datetime import datetime
from flask import Flask, request, jsonify
from kafka import KafkaProducer
from kafka.errors import KafkaError
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = Flask(__name__)

# Initialize Kafka Producer
producer = KafkaProducer(
    bootstrap_servers='localhost:9092',
    value_serializer=lambda v: json.dumps(v).encode('utf-8'),
    key_serializer=lambda k: str(k).encode('utf-8') if k else None,
    acks='all',
    retries=3,
    compression_type='snappy'
)

@app.route('/api/kafka/user-event', methods=['POST'])
def send_user_event():
    """Send user event via REST API"""
    try:
        data = request.get_json()
        
        if not data or 'user_id' not in data or 'event_type' not in data:
            return jsonify({'error': 'user_id and event_type are required'}), 400
        
        user_id = data['user_id']
        event_type = data['event_type']
        event_data = data.get('data', {})
        
        topic = f"security.user.{event_type}"
        
        message = {
            'event_id': str(uuid.uuid4()),
            'timestamp': datetime.utcnow().isoformat(),
            'user_id': user_id,
            'event_type': event_type,
            'data': event_data,
            'source': 'rest-api',
            'version': '1.0'
        }
        
        future = producer.send(topic, key=user_id, value=message)
        record_metadata = future.get(timeout=10)
        
        response = {
            'status': 'success',
            'message_id': message['event_id'],
            'topic': record_metadata.topic,
            'partition': record_metadata.partition,
            'offset': record_metadata.offset
        }
        
        logger.info(f"User event sent: {response}")
        return jsonify(response), 200
        
    except Exception as e:
        logger.error(f"Error sending user event: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/kafka/security-alert', methods=['POST'])
def send_security_alert():
    """Send security alert via REST API"""
    try:
        data = request.get_json()
        
        required_fields = ['alert_type', 'severity', 'data']
        if not data or not all(field in data for field in required_fields):
            return jsonify({'error': f'Required fields: {required_fields}'}), 400
        
        alert_type = data['alert_type']
        severity = data['severity']
        alert_data = data['data']
        
        topic = f"security.alert.{alert_type}"
        
        message = {
            'alert_id': str(uuid.uuid4()),
            'timestamp': datetime.utcnow().isoformat(),
            'alert_type': alert_type,
            'severity': severity,
            'data': alert_data,
            'source': 'rest-api',
            'version': '1.0'
        }
        
        future = producer.send(topic, key=alert_type, value=message)
        record_metadata = future.get(timeout=10)
        
        response = {
            'status': 'success',
            'alert_id': message['alert_id'],
            'topic': record_metadata.topic,
            'partition': record_metadata.partition,
            'offset': record_metadata.offset
        }
        
        logger.info(f"Security alert sent: {response}")
        return jsonify(response), 200
        
    except Exception as e:
        logger.error(f"Error sending security alert: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/kafka/monitoring-metric', methods=['POST'])
def send_monitoring_metric():
    """Send monitoring metric via REST API"""
    try:
        data = request.get_json()
        
        required_fields = ['metric_name', 'value']
        if not data or not all(field in data for field in required_fields):
            return jsonify({'error': f'Required fields: {required_fields}'}), 400
        
        metric_name = data['metric_name']
        metric_value = data['value']
        tags = data.get('tags', {})
        
        topic = "monitoring.metrics.collected"
        
        message = {
            'metric_id': str(uuid.uuid4()),
            'timestamp': datetime.utcnow().isoformat(),
            'metric_name': metric_name,
            'value': metric_value,
            'tags': tags,
            'source': 'rest-api',
            'version': '1.0'
        }
        
        future = producer.send(topic, key=metric_name, value=message)
        record_metadata = future.get(timeout=10)
        
        response = {
            'status': 'success',
            'metric_id': message['metric_id'],
            'topic': record_metadata.topic,
            'partition': record_metadata.partition,
            'offset': record_metadata.offset
        }
        
        logger.info(f"Monitoring metric sent: {response}")
        return jsonify(response), 200
        
    except Exception as e:
        logger.error(f"Error sending monitoring metric: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/health', methods=['GET'])
def health_check():
    """Health check endpoint"""
    return jsonify({'status': 'healthy', 'service': 'kafka-rest-producer'}), 200

if __name__ == '__main__':
    try:
        logger.info("Starting Kafka REST Producer API on port 5000")
        app.run(host='0.0.0.0', port=5000, debug=True)
    except KeyboardInterrupt:
        logger.info("Shutting down...")
    finally:
        producer.close()