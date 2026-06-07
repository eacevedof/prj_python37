import os
from typing import final, Self

from dotenv import load_dotenv
from ddd.shared.domain.enums.envvars_keys_enum import EnvvarsKeysEnum

load_dotenv()

@final
class EnvironmentReaderRawRepository:
    """Repository for reading environment variables required by the application."""

    _instance: "EnvironmentReaderRawRepository | None" = None

    @classmethod
    def get_instance(cls) -> Self:
        """Returns the singleton instance."""
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def get(self, key: str, default: str = "") -> str:
        """
        Reads an environment variable with a default value.

        Args:
            key: Environment variable name
            default: Default value if it doesn't exist

        Returns:
            str: Variable value or default
        """
        return os.getenv(key, default)

    def get_openai_api_key(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.OPENAI_API_KEY)

    def get_emt_client_id(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.EMT_CLIENT_ID)

    def get_emt_passkey(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.EMT_PASSKEY)

    def get_media_output_dir(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.MEDIA_OUTPUT_DIR)

    def __get_required(self, env_key: EnvvarsKeysEnum) -> str:
        return os.getenv(env_key.value or "")

