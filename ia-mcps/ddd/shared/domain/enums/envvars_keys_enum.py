from enum import StrEnum
from typing import final


@final
class EnvvarsKeysEnum(StrEnum):
    """Environment variable keys used by the application."""

    APP_LOG_PATH = "APP_LOG_PATH"
    OPENAI_API_KEY = "OPENAI_API_KEY"
    EMT_CLIENT_ID = "EMT_CLIENT_ID"
    EMT_PASSKEY = "EMT_PASSKEY"
