from enum import StrEnum
from typing import final


@final
class FileCheckerResponseKeyEnum(StrEnum):
    """Response dictionary keys for file checker results."""

    IS_VALID = "is_valid"
    ACTUAL_HASH = "actual_hash"
    EXPECTED_HASH = "expected_hash"
    ALGORITHM = "algorithm"
    FILE_PATH = "file_path"
