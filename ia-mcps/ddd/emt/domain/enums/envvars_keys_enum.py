from enum import Enum
from typing import final


@final
class EnvvarsKeysEnum(str, Enum):
    """Environment variable keys for EMT API configuration."""

    EMT_CLIENT_ID = "EMT_CLIENT_ID"
    EMT_PASSKEY = "EMT_PASSKEY"
