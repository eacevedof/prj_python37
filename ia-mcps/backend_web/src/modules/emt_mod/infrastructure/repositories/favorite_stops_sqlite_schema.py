"""Esquema de la tabla de paradas favoritas, en un único sitio.

Lo comparten el repositorio de lectura y el de escritura, que aseguran el mismo
DDL en cada conexión (`AbstractSqliteRepository`).

El índice único por (user_id, stop_nr) es parte del diseño, no un adorno: la
misma parada no se puede guardar dos veces para el mismo usuario, y la
propiedad de la fila queda escrita en la propia clave.
"""

FAVORITE_STOPS_TABLE_NAME = "app_mcp_stops"

FAVORITE_STOPS_SCHEMA_STATEMENTS: list[str] = [
    """
    CREATE TABLE IF NOT EXISTS app_mcp_stops (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        stop_nr TEXT NOT NULL,
        stop_description TEXT NOT NULL DEFAULT '',
        created_at TEXT NOT NULL DEFAULT '',
        updated_at TEXT NOT NULL DEFAULT ''
    )
    """,
    """
    CREATE UNIQUE INDEX IF NOT EXISTS idx_app_mcp_stops_user_stop
    ON app_mcp_stops (user_id, stop_nr)
    """,
]
