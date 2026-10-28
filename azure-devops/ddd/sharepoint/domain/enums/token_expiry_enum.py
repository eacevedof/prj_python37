from enum import IntEnum
from typing import final


@final
class TokenExpiryEnum(IntEnum):
    """Access token expiry timing for Microsoft Graph authentication (seconds)."""

    REFRESH_BUFFER_SECONDS = 60
    DEFAULT_EXPIRES_IN = 3600
