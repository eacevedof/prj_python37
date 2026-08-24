from typing import Self, final

from src.core.boot.env import get
from src.modules.shared.domain.enums.app_version_enum import AppVersionEnum
from src.modules.shared.domain.enums.boolean_input_enum import BooleanInputEnum
from src.modules.shared.domain.enums.env_var_enum import EnvVarEnum
from src.modules.shared.domain.enums.environment_enum import EnvironmentEnum

# Modelo de embeddings de memory_mod: pequeño y local (sin llamadas a OpenAI).
_DEFAULT_EMBEDDING_MODEL = "all-MiniLM-L6-v2"


@final
class EnvironmentReaderRawRepository:
    """Lectura de la configuración de entorno (datasource: raw / variables de entorno).

    **Un getter tipado por clave** (convención canónica): nadie fuera de aquí
    escribe el nombre de una variable de entorno, y los nombres viven en
    `EnvVarEnum`. Así se ve de un vistazo qué necesita un `.env` completo.
    """

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_app_version(self) -> str:
        app_version: str = AppVersionEnum.CURRENT.value
        return app_version

    def get_environment(self) -> str:
        return get(EnvVarEnum.APP_ENV)

    def get_log_path(self, default: str = "") -> str:
        return get(EnvVarEnum.APP_LOG_PATH, default)

    def get_mcp_api_key(self) -> str:
        return get(EnvVarEnum.APP_MCP_API_KEY)

    def get_emt_client_id(self) -> str:
        return get(EnvVarEnum.APP_EMT_CLIENT_ID)

    def get_emt_passkey(self) -> str:
        return get(EnvVarEnum.APP_EMT_PASSKEY)

    def get_sqlite_db_path(self, default: str = "") -> str:
        return get(EnvVarEnum.APP_SQLITE_DB_PATH, default)

    def get_openai_api_key(self) -> str:
        return get(EnvVarEnum.APP_OPENAI_API_KEY)

    def get_media_output_dir(self) -> str:
        return get(EnvVarEnum.APP_MEDIA_OUTPUT_DIR)

    def is_file_checker_url_download_allowed(self) -> bool:
        """Apagado salvo que se active explícitamente: descargar una URL que
        elige un modelo es la puerta a SSRF contra la red que alcance el proceso."""
        return get(EnvVarEnum.APP_FILE_CHECKER_ALLOW_URL_DOWNLOAD, "") in BooleanInputEnum.TRUTHY_VALUES

    def is_memory_store_file_allowed(self) -> bool:
        """Apagado salvo que se active explícitamente: `memory_store_file` lee la
        ruta que elige un modelo y deja el contenido recuperable con
        `memory_search`, así que es lectura arbitraria + exfiltración en dos pasos."""
        return get(EnvVarEnum.APP_MEMORY_ALLOW_STORE_FILE, "") in BooleanInputEnum.TRUTHY_VALUES

    def get_memory_chroma_path(self, default: str = "") -> str:
        return get(EnvVarEnum.APP_MEMORY_CHROMA_PATH, default)

    def get_memory_embedding_model(self) -> str:
        return get(EnvVarEnum.APP_MEMORY_EMBEDDING_MODEL, _DEFAULT_EMBEDDING_MODEL)

    def is_local(self) -> bool:
        return self.get_environment() == EnvironmentEnum.LOCAL.value

    def is_dev(self) -> bool:
        return self.get_environment() == EnvironmentEnum.DEVELOP.value

    def is_test(self) -> bool:
        return self.get_environment() == EnvironmentEnum.TEST.value

    def is_production(self) -> bool:
        return self.get_environment() == EnvironmentEnum.PRODUCTION.value

    def is_debug(self) -> bool:
        return get(EnvVarEnum.APP_DEBUG, "") in BooleanInputEnum.TRUTHY_VALUES
