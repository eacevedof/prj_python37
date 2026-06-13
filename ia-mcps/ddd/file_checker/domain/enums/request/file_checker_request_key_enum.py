from enum import StrEnum
from typing import final


@final
class FileCheckerRequestKeyEnum(StrEnum):
    """Request dictionary keys for file checker DTOs."""

    FILE_PATH = "file_path"
    EXPECTED_HASH = "expected_hash"
    ALGORITHM = "algorithm"
