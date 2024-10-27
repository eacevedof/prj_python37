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
    user_misc JSONB DEFAULT '{}',
    user_etl VARCHAR(1000) DEFAULT NULL
)
;

INSERT INTO app_users (user_uuid, user_code, user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, user_is_enabled) VALUES ('usr-1', 'usr-1', 'John Doe', 'johndoe', 'password123', 'johndoe@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_uuid, user_code, user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, user_is_enabled) VALUES ('usr-2', 'usr-2', 'Jane Smith', 'janesmith', 'password123', 'janesmith@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_uuid, user_code, user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, user_is_enabled) VALUES ('usr-3', 'usr-3', 'Alice Johnson', 'alicej', 'password123', 'alicej@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_uuid, user_code, user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, user_is_enabled) VALUES ('usr-4', 'usr-4', 'Bob Brown', 'bobb', 'password123', 'bobb@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_uuid, user_code, user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, user_is_enabled) VALUES ('usr-5', 'usr-5', 'Charlie Davis', 'charlied', 'password123', 'charlied@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_uuid, user_code, user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, user_is_enabled) VALUES ('usr-6', 'usr-6', 'David Evans', 'davide', 'password123', 'davide@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_uuid, user_code, user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, user_is_enabled) VALUES ('usr-7', 'usr-7', 'Eve Foster', 'evef', 'password123', 'evef@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_uuid, user_code, user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, user_is_enabled) VALUES ('usr-8', 'usr-8', 'Frank Green', 'frankg', 'password123', 'frankg@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_uuid, user_code, user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, user_is_enabled) VALUES ('usr-9', 'usr-9', 'Grace Harris', 'graceh', 'password123', 'graceh@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_uuid, user_code, user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, user_is_enabled) VALUES ('usr-10', 'usr-10', 'Hank Ingram', 'hanki', 'password123', 'hanki@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_uuid, user_code, user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, user_is_enabled) VALUES ('usr-11', 'usr-11', 'Ivy Jackson', 'ivyj', 'password123', 'ivyj@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_uuid, user_code, user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, user_is_enabled) VALUES ('usr-12', 'usr-12', 'Jack King', 'jackk', 'password123', 'jackk@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_uuid, user_code, user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, user_is_enabled) VALUES ('usr-13', 'usr-13', 'Karen Lee', 'karenl', 'password123', 'karenl@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_uuid, user_code, user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, user_is_enabled) VALUES ('usr-14', 'usr-14', 'Leo Martin', 'leom', 'password123', 'leom@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_uuid, user_code, user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, user_is_enabled) VALUES ('usr-15', 'usr-15', 'Mia Nelson', 'mian', 'password123', 'mian@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_uuid, user_code, user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, user_is_enabled) VALUES ('usr-16', 'usr-16', 'Nina Owens', 'ninao', 'password123', 'ninao@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_uuid, user_code, user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, user_is_enabled) VALUES ('usr-17', 'usr-17', 'Oscar Perez', 'oscarp', 'password123', 'oscarp@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_uuid, user_code, user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, user_is_enabled) VALUES ('usr-18', 'usr-18', 'Paul Quinn', 'paulq', 'password123', 'paulq@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_uuid, user_code, user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, user_is_enabled) VALUES ('usr-19', 'usr-19', 'Quincy Roberts', 'quincyr', 'password123', 'quincyr@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_uuid, user_code, user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, user_is_enabled) VALUES ('usr-20', 'usr-20', 'Rachel Scott', 'rachels', 'password123', 'rachels@example.com', 'admin', 'admin', 'admin', 1);