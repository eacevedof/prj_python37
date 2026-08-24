from typing import final


@final
class EnvVarEnum:
    """Nombres de las variables de entorno que consume la app.

    **Un getter tipado por clave**: nadie fuera de
    `EnvironmentReaderRawRepository` escribe el nombre de una variable, así que
    este fichero es el inventario de lo que necesita un `.env` completo.

    **Toda clave lleva el prefijo `APP_`** (2026-08-24): lo que consume la app se
    distingue de un vistazo de lo que pone el sistema o el contenedor (`PATH`,
    `TZ`, `PYTHONPATH`), y un `env | grep APP_` saca la configuración entera.
    """

    APP_ENV = "APP_ENV"
    APP_DEBUG = "APP_DEBUG"
    APP_LOG_PATH = "APP_LOG_PATH"

    # Borde de auth: clave que autoriza a consumir los endpoints /mcp/*.
    APP_MCP_API_KEY = "APP_MCP_API_KEY"

    # emt_mod
    APP_EMT_CLIENT_ID = "APP_EMT_CLIENT_ID"
    APP_EMT_PASSKEY = "APP_EMT_PASSKEY"

    # Base de datos SQLite de la app (hoy ningún módulo la usa; ver AbstractSqliteRepository).
    APP_SQLITE_DB_PATH = "APP_SQLITE_DB_PATH"

    # media_mod
    APP_OPENAI_API_KEY = "APP_OPENAI_API_KEY"
    APP_MEDIA_OUTPUT_DIR = "APP_MEDIA_OUTPUT_DIR"

    # filechecker_mod — interruptor de la descarga de URL (por defecto APAGADA).
    APP_FILE_CHECKER_ALLOW_URL_DOWNLOAD = "APP_FILE_CHECKER_ALLOW_URL_DOWNLOAD"

    # memory_mod — interruptor de `memory_store_file` (por defecto APAGADO).
    APP_MEMORY_ALLOW_STORE_FILE = "APP_MEMORY_ALLOW_STORE_FILE"
    APP_MEMORY_CHROMA_PATH = "APP_MEMORY_CHROMA_PATH"
    APP_MEMORY_EMBEDDING_MODEL = "APP_MEMORY_EMBEDDING_MODEL"
