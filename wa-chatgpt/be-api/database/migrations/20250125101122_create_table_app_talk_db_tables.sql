DROP TABLE IF EXISTS app_talk_db_tables
;

CREATE TABLE app_talk_db_tables
(
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(10) DEFAULT NULL,
    updated_at TIMESTAMP DEFAULT NULL,
    updated_by VARCHAR(10) DEFAULT NULL,
    deleted_at TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(10) DEFAULT NULL,

    id SERIAL PRIMARY KEY,
    context_id INT NOT NULL,

    table_name VARCHAR(100) NOT NULL,
    table_description VARCHAR(500) NOT NULL
)
;
