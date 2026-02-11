from enum import StrEnum
from typing import final


@final
class EnvvarsKeysEnum(StrEnum):
    AZURE_API_VERSION = "AZURE_API_VERSION"
    AZURE_ORGANIZATION_NAME = "AZURE_ORGANIZATION_NAME"
    AZURE_PAT = "AZURE_PAT"

    APP_DEFAULT_PROJECT = "APP_DEFAULT_PROJECT"
    APP_LOG_PATH = "APP_LOG_PATH"