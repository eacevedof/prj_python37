#!/bin/bash
# Direct Kafka Producer using kafka-console-producer
# Requires Kafka binaries or Docker access to Kafka container

KAFKA_BROKER="localhost:9092"
CONTAINER_NAME="cont-kafka-br1"

echo "=== Direct Kafka Producer Examples ==="
echo "Kafka Broker: $KAFKA_BROKER"
echo ""

# Function to send message using docker exec
send_message_docker() {
    local topic=$1
    local key=$2
    local message=$3
    
    echo "Sending to topic: $topic"
    echo "Key: $key"
    echo "Message: $message"
    echo ""
    
    # Using docker exec to access kafka-console-producer inside container
    echo "$message" | docker exec -i "$CONTAINER_NAME" /opt/kafka/bin/kafka-console-producer.sh \
        --bootstrap-server localhost:9092 \
        --topic "$topic" \
        --property "key.separator=:" \
        --property "parse.key=true" \
        --property "key.serializer=org.apache.kafka.common.serialization.StringSerializer" \
        --property "value.serializer=org.apache.kafka.common.serialization.StringSerializer" \
        --property "compression.type=snappy" \
        < <(echo "$key:$message")
    
    echo "Message sent successfully!"
    echo "----------------------------------------"
    echo ""
}

# Function to create topic if it doesn't exist
create_topic() {
    local topic=$1
    local partitions=${2:-3}
    local replication=${3:-1}
    
    echo "Creating topic: $topic"
    docker exec "$CONTAINER_NAME" /opt/kafka/bin/kafka-topics.sh \
        --bootstrap-server localhost:9092 \
        --create \
        --topic "$topic" \
        --partitions "$partitions" \
        --replication-factor "$replication" \
        --if-not-exists
    echo ""
}

# Check if Kafka container is running
if ! docker ps | grep -q "$CONTAINER_NAME"; then
    echo "ERROR: Kafka container '$CONTAINER_NAME' is not running"
    echo "Start it with: docker-compose up -d kafka-br1"
    exit 1
fi

# Create topics
echo "1. Creating topics..."
create_topic "security.user.login"
create_topic "security.user.password_change"
create_topic "security.alert.suspicious_login"
create_topic "security.alert.malware_detected"
create_topic "monitoring.metrics.collected"

# Send messages
echo "2. Sending user login event..."
USER_LOGIN='{
    "event_id": "evt_001",
    "timestamp": "'$(date -u +%Y-%m-%dT%H:%M:%S.%3NZ)'",
    "user_id": "user_123",
    "event_type": "login",
    "data": {
        "ip_address": "192.168.1.100",
        "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)",
        "session_id": "sess_456"
    },
    "source": "curl-script",
    "version": "1.0"
}'
send_message_docker "security.user.login" "user_123" "$USER_LOGIN"

echo "3. Sending password change event..."
PASSWORD_CHANGE='{
    "event_id": "evt_002",
    "timestamp": "'$(date -u +%Y-%m-%dT%H:%M:%S.%3NZ)'",
    "user_id": "user_456",
    "event_type": "password_change",
    "data": {
        "ip_address": "192.168.1.101",
        "previous_password_hash": "old_hash_12345"
    },
    "source": "curl-script",
    "version": "1.0"
}'
send_message_docker "security.user.password_change" "user_456" "$PASSWORD_CHANGE"

echo "4. Sending suspicious login alert..."
SUSPICIOUS_LOGIN='{
    "alert_id": "alert_001",
    "timestamp": "'$(date -u +%Y-%m-%dT%H:%M:%S.%3NZ)'",
    "alert_type": "suspicious_login",
    "severity": "HIGH",
    "data": {
        "user_id": "user_789",
        "failed_attempts": 5,
        "ip_address": "10.0.0.1",
        "location": "Unknown",
        "threat_score": 85
    },
    "source": "curl-script",
    "version": "1.0"
}'
send_message_docker "security.alert.suspicious_login" "suspicious_login" "$SUSPICIOUS_LOGIN"

echo "5. Sending malware detection alert..."
MALWARE_ALERT='{
    "alert_id": "alert_002",
    "timestamp": "'$(date -u +%Y-%m-%dT%H:%M:%S.%3NZ)'",
    "alert_type": "malware_detected",
    "severity": "CRITICAL",
    "data": {
        "file_hash": "abc123def456789",
        "file_path": "/tmp/suspicious.exe",
        "file_size": 1024000,
        "detection_engine": "ClamAV",
        "signature": "Trojan.Generic.12345",
        "quarantine_status": "isolated"
    },
    "source": "curl-script",
    "version": "1.0"
}'
send_message_docker "security.alert.malware_detected" "malware_detected" "$MALWARE_ALERT"

echo "6. Sending CPU usage metric..."
CPU_METRIC='{
    "metric_id": "metric_001",
    "timestamp": "'$(date -u +%Y-%m-%dT%H:%M:%S.%3NZ)'",
    "metric_name": "cpu_usage_percent",
    "value": 75.5,
    "unit": "percent",
    "tags": {
        "host": "web-server-01",
        "environment": "production",
        "datacenter": "us-east-1",
        "service": "web-frontend"
    },
    "source": "curl-script",
    "version": "1.0"
}'
send_message_docker "monitoring.metrics.collected" "cpu_usage_percent" "$CPU_METRIC"

echo "7. Sending memory usage metric..."
MEMORY_METRIC='{
    "metric_id": "metric_002",
    "timestamp": "'$(date -u +%Y-%m-%dT%H:%M:%S.%3NZ)'",
    "metric_name": "memory_usage_bytes",
    "value": 2147483648,
    "unit": "bytes",
    "tags": {
        "host": "db-server-01",
        "environment": "production",
        "datacenter": "us-east-1",
        "service": "database"
    },
    "source": "curl-script",
    "version": "1.0"
}'
send_message_docker "monitoring.metrics.collected" "memory_usage_bytes" "$MEMORY_METRIC"

echo "=== All messages sent to Kafka on port 9092 ==="
echo ""
echo "To verify messages were received, run:"
echo "docker exec -it $CONTAINER_NAME /opt/kafka/bin/kafka-console-consumer.sh \\"
echo "  --bootstrap-server localhost:9092 \\"
echo "  --topic security.user.login \\"
echo "  --from-beginning"
echo ""
echo "Or use the Python consumer:"
echo "python kafka-consumer.py"