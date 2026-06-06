import os
from typing import final, Self

from ddd.shared.domain.enums.envvars_keys_enum import EnvvarsKeysEnum


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

    def __get_required(self, key: EnvvarsKeysEnum) -> str:
        value = os.getenv(key)
        if value is None:
            raise ValueError(f"Missing required environment variable: {key}")
        return value
