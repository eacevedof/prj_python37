"""Esquema de la tabla de usuarios, en un único sitio.

Lo comparten el repositorio de lectura y el de escritura: los dos aseguran el
mismo DDL en cada conexión (`AbstractSqliteRepository`), así que la definición
no puede vivir duplicada en cada uno o acabarían divergiendo.

`authenticated_at` es la última vez que el usuario validó su contraseña: de ahí
sale la ventana de 7 días, y por eso se guarda en la propia fila y no en memoria
del proceso (un `make dev` no debe volver a pedirla).
"""

USERS_TABLE_NAME = "app_users"

USERS_SCHEMA_STATEMENTS: list[str] = [
    """
    CREATE TABLE IF NOT EXISTS app_users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_uuid TEXT NOT NULL,
        user_role_id INTEGER NOT NULL DEFAULT 2,
        user_tg_id TEXT NOT NULL,
        user_name TEXT NOT NULL DEFAULT '',
        user_pwd TEXT NOT NULL DEFAULT '',
        is_enabled INTEGER NOT NULL DEFAULT 1,
        authenticated_at TEXT NOT NULL DEFAULT '',
        created_at TEXT NOT NULL DEFAULT '',
        updated_at TEXT NOT NULL DEFAULT ''
    )
    """,
    "CREATE UNIQUE INDEX IF NOT EXISTS idx_app_users_uuid ON app_users (user_uuid)",
    "CREATE UNIQUE INDEX IF NOT EXISTS idx_app_users_tg_id ON app_users (user_tg_id)",
]
