from enum import Enum
from typing import final

@final
class AuthKeyEnum(Enum):
    PROJECT_AUTH_TOKEN = "lzrmsaph-auth"
    DEVICE_AUTH_TOKEN = "lzrmsaph-device-auth"