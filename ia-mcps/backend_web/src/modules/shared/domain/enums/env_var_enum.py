from typing import final


@final
class EnvVarEnum:
    """Nombres de las variables de entorno que consume la app.

    **Un getter tipado por clave**: nadie fuera de
    `EnvironmentReaderRawRepository` escribe el nombre de una variable, así que
    este fichero es el inventario de lo que necesita un `.env` completo.
    """

    APP_ENV = "APP_ENV"
    APP_DEBUG = "APP_DEBUG"
    APP_LOG_PATH = "APP_LOG_PATH"

    # Borde de auth: clave que autoriza a consumir los endpoints /mcp/*.
    MCP_API_KEY = "MCP_API_KEY"

    # emt_mod
    EMT_CLIENT_ID = "EMT_CLIENT_ID"
    EMT_PASSKEY = "EMT_PASSKEY"

    # Base de datos SQLite de la app (hoy ningún módulo la usa; ver AbstractSqliteRepository).
    SQLITE_DB_PATH = "SQLITE_DB_PATH"

    # media_mod
    OPENAI_API_KEY = "OPENAI_API_KEY"
    MEDIA_OUTPUT_DIR = "MEDIA_OUTPUT_DIR"

    # filechecker_mod — interruptor de la descarga de URL (por defecto APAGADA).
    FILE_CHECKER_ALLOW_URL_DOWNLOAD = "FILE_CHECKER_ALLOW_URL_DOWNLOAD"

    # memory_mod — interruptor de `memory_store_file` (por defecto APAGADO).
    MEMORY_ALLOW_STORE_FILE = "MEMORY_ALLOW_STORE_FILE"
    MEMORY_CHROMA_PATH = "MEMORY_CHROMA_PATH"
    MEMORY_EMBEDDING_MODEL = "MEMORY_EMBEDDING_MODEL"
