MYSQLS = {
    "my-1": {
        "server_id": 1,
        "host": "localhost",
        "port": 3306,
        "database": "db_kafka_cdc",
        "user": "root",
        "password": "root",

        "use_binlog": True,
        "polling_interval": 30,

        "kafka": {
            "topic": "mysql.cdc.db_kafka_cdc",
            "partitions": 3,
        },

        "tables_to_monitor": {
            "users": "updated_at",
            "user_sessions": "created_at",
            "security_events": "timestamp",
            "audit_logs": "created_at",
            "failed_logins": "attempt_time",
        },

    },
}