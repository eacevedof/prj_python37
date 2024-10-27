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
    user_name VARCHAR(100) NOT NULL,
    user_login VARCHAR(100) NOT NULL UNIQUE,
    user_password VARCHAR(100) NOT NULL,
    user_email VARCHAR(100) NOT NULL UNIQUE,
    user_tmp VARCHAR(100) NOT NULL UNIQUE,
    is_enabled INT DEFAULT 1,
    user_misc JSONB DEFAULT '{}'
)
;

INSERT INTO app_users (user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, enabled) VALUES ('John Doe', 'johndoe', 'password123', 'johndoe@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, enabled) VALUES ('Jane Smith', 'janesmith', 'password123', 'janesmith@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, enabled) VALUES ('Alice Johnson', 'alicej', 'password123', 'alicej@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, enabled) VALUES ('Bob Brown', 'bobb', 'password123', 'bobb@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, enabled) VALUES ('Charlie Davis', 'charlied', 'password123', 'charlied@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, enabled) VALUES ('David Evans', 'davide', 'password123', 'davide@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, enabled) VALUES ('Eve Foster', 'evef', 'password123', 'evef@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, enabled) VALUES ('Frank Green', 'frankg', 'password123', 'frankg@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, enabled) VALUES ('Grace Harris', 'graceh', 'password123', 'graceh@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, enabled) VALUES ('Hank Ingram', 'hanki', 'password123', 'hanki@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, enabled) VALUES ('Ivy Jackson', 'ivyj', 'password123', 'ivyj@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, enabled) VALUES ('Jack King', 'jackk', 'password123', 'jackk@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, enabled) VALUES ('Karen Lee', 'karenl', 'password123', 'karenl@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, enabled) VALUES ('Leo Martin', 'leom', 'password123', 'leom@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, enabled) VALUES ('Mia Nelson', 'mian', 'password123', 'mian@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, enabled) VALUES ('Nina Owens', 'ninao', 'password123', 'ninao@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, enabled) VALUES ('Oscar Perez', 'oscarp', 'password123', 'oscarp@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, enabled) VALUES ('Paul Quinn', 'paulq', 'password123', 'paulq@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, enabled) VALUES ('Quincy Roberts', 'quincyr', 'password123', 'quincyr@example.com', 'admin', 'admin', 'admin', 1);
INSERT INTO app_users (user_name, user_login, user_password, user_email, created_by, updated_by, deleted_by, enabled) VALUES ('Rachel Scott', 'rachels', 'password123', 'rachels@example.com', 'admin', 'admin', 'admin', 1);