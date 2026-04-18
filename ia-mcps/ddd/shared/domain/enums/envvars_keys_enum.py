from enum import StrEnum
from typing import final


@final
class EnvvarsKeysEnum(StrEnum):
    """Environment variable keys used by the application."""

    APP_LOG_PATH = "APP_LOG_PATH"
