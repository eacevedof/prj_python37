-- Test MySQL setup for CDC Worker
-- Run this to create test database and tables

CREATE DATABASE IF NOT EXISTS db_kafka_cdc;
USE db_kafka_cdc;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    status ENUM('active', 'inactive', 'suspended') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- User sessions table
CREATE TABLE IF NOT EXISTS user_sessions (
    session_id VARCHAR(255) PRIMARY KEY,
    user_id INT NOT NULL,
    ip_address VARCHAR(45),
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Security events table  
CREATE TABLE IF NOT EXISTS security_events (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    event_type ENUM('login', 'logout', 'password_change', 'account_locked', 'suspicious_activity') NOT NULL,
    severity ENUM('low', 'medium', 'high', 'critical') DEFAULT 'low',
    ip_address VARCHAR(45),
    details JSON,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Audit logs table
CREATE TABLE IF NOT EXISTS audit_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    table_name VARCHAR(100) NOT NULL,
    operation ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    old_values JSON,
    new_values JSON,
    user_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Failed login attempts
CREATE TABLE IF NOT EXISTS failed_logins (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100),
    ip_address VARCHAR(45) NOT NULL,
    user_agent TEXT,
    attempt_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    failure_reason VARCHAR(255)
);

-- Insert sample data
INSERT INTO users (username, email, password_hash, status) VALUES
('admin', 'admin@example.com', 'hashed_password_123', 'active'),
('john_doe', 'john@example.com', 'hashed_password_456', 'active'),
('jane_smith', 'jane@example.com', 'hashed_password_789', 'inactive');

INSERT INTO security_events (user_id, event_type, severity, ip_address, details) VALUES
(1, 'login', 'low', '192.168.1.100', '{"browser": "Chrome", "location": "Office"}'),
(2, 'password_change', 'medium', '192.168.1.101', '{"previous_change": "2024-01-15"}'),
(null, 'suspicious_activity', 'high', '10.0.0.1', '{"reason": "multiple_failed_attempts", "count": 5}');

INSERT INTO failed_logins (username, ip_address, user_agent, failure_reason) VALUES
('admin', '10.0.0.1', 'curl/7.68.0', 'invalid_password'),
('unknown_user', '192.168.1.200', 'Mozilla/5.0...', 'user_not_found');

-- Show tables and sample data
SHOW TABLES;
SELECT COUNT(*) as user_count FROM users;
SELECT COUNT(*) as events_count FROM security_events;
SELECT COUNT(*) as failed_login_count FROM failed_logins;