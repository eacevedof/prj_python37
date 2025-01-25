DROP TABLE IF EXISTS app_talk_db_schemas
;

CREATE TABLE app_talk_db_schemas
(
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(10) DEFAULT NULL,
    updated_at TIMESTAMP DEFAULT NULL,
    updated_by VARCHAR(10) DEFAULT NULL,
    deleted_at TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(10) DEFAULT NULL,

    id SERIAL PRIMARY KEY,
    context_id INT NOT NULL,

    db_field VARCHAR(100) NOT NULL,
    db_description VARCHAR(100) NOT NULL
)
;
