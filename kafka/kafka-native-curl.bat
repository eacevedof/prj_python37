@echo off
REM Direct Kafka Producer using kafka-console-producer
REM Requires Docker access to Kafka container

set KAFKA_BROKER=localhost:9092
set CONTAINER_NAME=cont-kafka-br1

echo === Direct Kafka Producer Examples ===
echo Kafka Broker: %KAFKA_BROKER%
echo.

REM Check if Kafka container is running
docker ps | findstr %CONTAINER_NAME% >nul
if errorlevel 1 (
    echo ERROR: Kafka container '%CONTAINER_NAME%' is not running
    echo Start it with: docker-compose up -d kafka-br1
    pause
    exit /b 1
)

echo 1. Creating topics...
docker exec %CONTAINER_NAME% /opt/kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --create --topic security.user.login --partitions 3 --replication-factor 1 --if-not-exists
docker exec %CONTAINER_NAME% /opt/kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --create --topic security.user.password_change --partitions 3 --replication-factor 1 --if-not-exists
docker exec %CONTAINER_NAME% /opt/kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --create --topic security.alert.suspicious_login --partitions 3 --replication-factor 1 --if-not-exists
docker exec %CONTAINER_NAME% /opt/kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --create --topic security.alert.malware_detected --partitions 3 --replication-factor 1 --if-not-exists
docker exec %CONTAINER_NAME% /opt/kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --create --topic monitoring.metrics.collected --partitions 3 --replication-factor 1 --if-not-exists
echo.

echo 2. Sending user login event...
echo user_123:{"event_id":"evt_001","timestamp":"%date:~10,4%-%date:~4,2%-%date:~7,2%T%time:~0,2%:%time:~3,2%:%time:~6,2%.000Z","user_id":"user_123","event_type":"login","data":{"ip_address":"192.168.1.100","user_agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64)","session_id":"sess_456"},"source":"curl-script","version":"1.0"} | docker exec -i %CONTAINER_NAME% /opt/kafka/bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic security.user.login --property "key.separator=:" --property "parse.key=true"
echo Message sent successfully!
echo ----------------------------------------
echo.

echo 3. Sending password change event...
echo user_456:{"event_id":"evt_002","timestamp":"%date:~10,4%-%date:~4,2%-%date:~7,2%T%time:~0,2%:%time:~3,2%:%time:~6,2%.000Z","user_id":"user_456","event_type":"password_change","data":{"ip_address":"192.168.1.101","previous_password_hash":"old_hash_12345"},"source":"curl-script","version":"1.0"} | docker exec -i %CONTAINER_NAME% /opt/kafka/bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic security.user.password_change --property "key.separator=:" --property "parse.key=true"
echo Message sent successfully!
echo ----------------------------------------
echo.

echo 4. Sending suspicious login alert...
echo suspicious_login:{"alert_id":"alert_001","timestamp":"%date:~10,4%-%date:~4,2%-%date:~7,2%T%time:~0,2%:%time:~3,2%:%time:~6,2%.000Z","alert_type":"suspicious_login","severity":"HIGH","data":{"user_id":"user_789","failed_attempts":5,"ip_address":"10.0.0.1","location":"Unknown","threat_score":85},"source":"curl-script","version":"1.0"} | docker exec -i %CONTAINER_NAME% /opt/kafka/bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic security.alert.suspicious_login --property "key.separator=:" --property "parse.key=true"
echo Message sent successfully!
echo ----------------------------------------
echo.

echo 5. Sending malware detection alert...
echo malware_detected:{"alert_id":"alert_002","timestamp":"%date:~10,4%-%date:~4,2%-%date:~7,2%T%time:~0,2%:%time:~3,2%:%time:~6,2%.000Z","alert_type":"malware_detected","severity":"CRITICAL","data":{"file_hash":"abc123def456789","file_path":"/tmp/suspicious.exe","file_size":1024000,"detection_engine":"ClamAV","signature":"Trojan.Generic.12345","quarantine_status":"isolated"},"source":"curl-script","version":"1.0"} | docker exec -i %CONTAINER_NAME% /opt/kafka/bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic security.alert.malware_detected --property "key.separator=:" --property "parse.key=true"
echo Message sent successfully!
echo ----------------------------------------
echo.

echo 6. Sending CPU usage metric...
echo cpu_usage_percent:{"metric_id":"metric_001","timestamp":"%date:~10,4%-%date:~4,2%-%date:~7,2%T%time:~0,2%:%time:~3,2%:%time:~6,2%.000Z","metric_name":"cpu_usage_percent","value":75.5,"unit":"percent","tags":{"host":"web-server-01","environment":"production","datacenter":"us-east-1","service":"web-frontend"},"source":"curl-script","version":"1.0"} | docker exec -i %CONTAINER_NAME% /opt/kafka/bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic monitoring.metrics.collected --property "key.separator=:" --property "parse.key=true"
echo Message sent successfully!
echo ----------------------------------------
echo.

echo 7. Sending memory usage metric...
echo memory_usage_bytes:{"metric_id":"metric_002","timestamp":"%date:~10,4%-%date:~4,2%-%date:~7,2%T%time:~0,2%:%time:~3,2%:%time:~6,2%.000Z","metric_name":"memory_usage_bytes","value":2147483648,"unit":"bytes","tags":{"host":"db-server-01","environment":"production","datacenter":"us-east-1","service":"database"},"source":"curl-script","version":"1.0"} | docker exec -i %CONTAINER_NAME% /opt/kafka/bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic monitoring.metrics.collected --property "key.separator=:" --property "parse.key=true"
echo Message sent successfully!
echo ----------------------------------------
echo.

echo === All messages sent to Kafka on port 9092 ===
echo.
echo To verify messages were received, run:
echo docker exec -it %CONTAINER_NAME% /opt/kafka/bin/kafka-console-consumer.sh ^
echo   --bootstrap-server localhost:9092 ^
echo   --topic security.user.login ^
echo   --from-beginning
echo.
echo Or use the Python consumer:
echo python kafka-consumer.py
echo.
pause