import os
from typing import final

from ddd.shared.domain.enums.envvars_keys_enum import EnvvarsKeysEnum


@final
class EnvironmentReaderRawRepository:

    @staticmethod
    def get_instance() -> "EnvironmentReaderRawRepository":
        return EnvironmentReaderRawRepository()

    def get_azure_organization_name(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.AZURE_ORGANIZATION_NAME)

    def get_azure_api_version(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.AZURE_API_VERSION)

    def get_azure_pat(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.AZURE_PAT)

    def get_app_default_project(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.APP_DEFAULT_PROJECT)

    def __get_required(self, key: EnvvarsKeysEnum) -> str:
        value = os.getenv(key)
        if value is None:
            raise ValueError(f"Missing required environment variable: {key}")
        return value

