DROP TABLE IF EXISTS app_talk_db_table_fields
;

CREATE TABLE app_talk_db_table_fields
(
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(10) DEFAULT NULL,
    updated_at TIMESTAMP DEFAULT NULL,
    updated_by VARCHAR(10) DEFAULT NULL,
    deleted_at TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(10) DEFAULT NULL,

    id SERIAL PRIMARY KEY,
    table_id INT NOT NULL,

    field_name VARCHAR(100) NOT NULL,
    field_description VARCHAR(500) NOT NULL
)
;
