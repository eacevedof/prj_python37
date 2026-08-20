from enum import StrEnum
from typing import final


@final
class FileCheckerHttpResponseKeyEnum(StrEnum):
    """HTTP response envelope keys for controller."""

    CODE = "code"
    DATA = "data"
    ERROR = "error"
