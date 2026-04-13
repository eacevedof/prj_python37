import os
from typing import final

from ddd.shared.domain.enums.envvars_keys_enum import EnvvarsKeysEnum


@final
class EnvironmentReaderRawRepository:
    """Repository for reading environment variables required by the application."""

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

    def get_sharepoint_client_id(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.SHAREPOINT_CLIENT_ID)

    def get_sharepoint_client_secret(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.SHAREPOINT_CLIENT_SECRET)

    def get_sharepoint_tenant_id(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.SHAREPOINT_TENANT_ID)

    def get_sharepoint_site_id(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.SHAREPOINT_SITE_ID)

    def get_local_docker_lamp_path(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.LOCAL_DOCKER_LAMP_PATH)

    def get_local_www_path(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.LOCAL_WWW_PATH)

    def get_local_vhosts_file(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.LOCAL_VHOSTS_FILE)

    def get_local_hosts_file(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.LOCAL_HOSTS_FILE)

    def get_local_base_env_file(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.LOCAL_BASE_ENV_FILE)

    def __get_required(self, key: EnvvarsKeysEnum) -> str:
        value = os.getenv(key)
        if value is None:
            raise ValueError(f"Missing required environment variable: {key}")
        return value

