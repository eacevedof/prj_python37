import os
from typing import Optional, final
from dotenv import load_dotenv


@final
class EnvironmentReaderRawRepository:

    def __init__(self, env_path: Optional[str] = None):
        load_dotenv(env_path)

    @staticmethod
    def get_instance() -> "EnvironmentReaderRawRepository":
        return EnvironmentReaderRawRepository()

    def get_azure_organization_name(self) -> str:
        return self.__get_required("AZURE_ORGANIZATION_NAME")

    def get_azure_api_version(self) -> str:
        return self.__get_required("AZURE_API_VERSION")

    def get_azure_pat(self) -> str:
        return self.__get_required("AZURE_PAT")

    def __get_required(self, key: str) -> str:
        value = os.getenv(key)
        if value is None:
            raise ValueError(f"Missing required environment variable: {key}")
        return value

    def __get_optional(self, key: str, default: str = "") -> str:
        return os.getenv(key, default)
