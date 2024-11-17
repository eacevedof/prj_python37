DROP TABLE IF EXISTS app_users
;

CREATE TABLE app_users
(
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(10) DEFAULT NULL,
    updated_at TIMESTAMP DEFAULT NULL,
    updated_by VARCHAR(10) DEFAULT NULL,
    deleted_at TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(10) DEFAULT NULL,
    id SERIAL PRIMARY KEY,
    user_uuid VARCHAR(100) NOT NULL UNIQUE,
    user_code VARCHAR(100) DEFAULT NULL,
    user_name VARCHAR(100) NOT NULL,
    user_login VARCHAR(100) NOT NULL UNIQUE,
    user_password VARCHAR(100) NOT NULL,
    user_email VARCHAR(100) NOT NULL UNIQUE,
    user_is_enabled INT DEFAULT 1,
    user_misc JSONB DEFAULT NULL,
    user_etl VARCHAR(1000) DEFAULT NULL
)
;
