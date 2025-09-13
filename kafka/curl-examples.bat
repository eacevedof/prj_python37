@echo off
REM Kafka REST Producer - cURL Examples for Windows
REM Make sure to start the REST API first: python kafka-rest-producer.py

set BASE_URL=http://localhost:9092/api/kafka

echo === Kafka Producer cURL Examples ===
echo.

REM Health check
echo 1. Health Check:
echo curl -X GET http://localhost:9092/health
echo.
curl -X GET http://localhost:9092/health
echo.
echo.

REM User login event
echo 2. User Login Event:
echo curl -X POST %BASE_URL%/user-event ^
echo   -H "Content-Type: application/json" ^
echo   -d "{\"user_id\": \"user_123\", \"event_type\": \"login\", \"data\": {\"ip_address\": \"192.168.1.100\", \"user_agent\": \"Mozilla/5.0...\", \"session_id\": \"sess_456\"}}"
echo.
curl -X POST "%BASE_URL%/user-event" ^
  -H "Content-Type: application/json" ^
  -d "{\"user_id\": \"user_123\", \"event_type\": \"login\", \"data\": {\"ip_address\": \"192.168.1.100\", \"user_agent\": \"Mozilla/5.0...\", \"session_id\": \"sess_456\"}}"
echo.
echo.

REM Password change event
echo 3. Password Change Event:
echo curl -X POST %BASE_URL%/user-event ^
echo   -H "Content-Type: application/json" ^
echo   -d "{\"user_id\": \"user_456\", \"event_type\": \"password_change\", \"data\": {\"ip_address\": \"192.168.1.101\", \"previous_password_hash\": \"old_hash\"}}"
echo.
curl -X POST "%BASE_URL%/user-event" ^
  -H "Content-Type: application/json" ^
  -d "{\"user_id\": \"user_456\", \"event_type\": \"password_change\", \"data\": {\"ip_address\": \"192.168.1.101\", \"previous_password_hash\": \"old_hash\"}}"
echo.
echo.

REM Security alert - Suspicious login
echo 4. Security Alert - Suspicious Login:
echo curl -X POST %BASE_URL%/security-alert ^
echo   -H "Content-Type: application/json" ^
echo   -d "{\"alert_type\": \"suspicious_login\", \"severity\": \"HIGH\", \"data\": {\"user_id\": \"user_789\", \"failed_attempts\": 5, \"ip_address\": \"10.0.0.1\", \"location\": \"Unknown\"}}"
echo.
curl -X POST "%BASE_URL%/security-alert" ^
  -H "Content-Type: application/json" ^
  -d "{\"alert_type\": \"suspicious_login\", \"severity\": \"HIGH\", \"data\": {\"user_id\": \"user_789\", \"failed_attempts\": 5, \"ip_address\": \"10.0.0.1\", \"location\": \"Unknown\"}}"
echo.
echo.

REM Security alert - Malware detected
echo 5. Security Alert - Malware Detected:
echo curl -X POST %BASE_URL%/security-alert ^
echo   -H "Content-Type: application/json" ^
echo   -d "{\"alert_type\": \"malware_detected\", \"severity\": \"CRITICAL\", \"data\": {\"file_hash\": \"abc123def456\", \"file_path\": \"/tmp/suspicious.exe\", \"detection_engine\": \"ClamAV\"}}"
echo.
curl -X POST "%BASE_URL%/security-alert" ^
  -H "Content-Type: application/json" ^
  -d "{\"alert_type\": \"malware_detected\", \"severity\": \"CRITICAL\", \"data\": {\"file_hash\": \"abc123def456\", \"file_path\": \"/tmp/suspicious.exe\", \"detection_engine\": \"ClamAV\"}}"
echo.
echo.

REM Monitoring metric - CPU usage
echo 6. Monitoring Metric - CPU Usage:
echo curl -X POST %BASE_URL%/monitoring-metric ^
echo   -H "Content-Type: application/json" ^
echo   -d "{\"metric_name\": \"cpu_usage_percent\", \"value\": 75.5, \"tags\": {\"host\": \"web-server-01\", \"environment\": \"production\"}}"
echo.
curl -X POST "%BASE_URL%/monitoring-metric" ^
  -H "Content-Type: application/json" ^
  -d "{\"metric_name\": \"cpu_usage_percent\", \"value\": 75.5, \"tags\": {\"host\": \"web-server-01\", \"environment\": \"production\"}}"
echo.
echo.

REM Monitoring metric - Memory usage
echo 7. Monitoring Metric - Memory Usage:
echo curl -X POST %BASE_URL%/monitoring-metric ^
echo   -H "Content-Type: application/json" ^
echo   -d "{\"metric_name\": \"memory_usage_bytes\", \"value\": 2147483648, \"tags\": {\"host\": \"db-server-01\", \"environment\": \"production\"}}"
echo.
curl -X POST "%BASE_URL%/monitoring-metric" ^
  -H "Content-Type: application/json" ^
  -d "{\"metric_name\": \"memory_usage_bytes\", \"value\": 2147483648, \"tags\": {\"host\": \"db-server-01\", \"environment\": \"production\"}}"
echo.
echo.

echo === All examples completed ===
echo.
echo To monitor these messages, run in another terminal:
echo python kafka-consumer.py
echo.
pause