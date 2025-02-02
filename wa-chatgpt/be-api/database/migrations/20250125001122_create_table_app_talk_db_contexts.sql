DROP TABLE IF EXISTS app_talk_db_contexts
;

CREATE TABLE app_talk_db_contexts
(
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(10) DEFAULT NULL,
    updated_at TIMESTAMP DEFAULT NULL,
    updated_by VARCHAR(10) DEFAULT NULL,
    deleted_at TIMESTAMP DEFAULT NULL,
    deleted_by VARCHAR(10) DEFAULT NULL,
    id SERIAL PRIMARY KEY,
    context_uuid VARCHAR(100) NOT NULL UNIQUE,
    owner_id INT NOT NULL,
    context_name VARCHAR(100) NOT NULL,
    context_misc JSONB DEFAULT NULL
)
;
