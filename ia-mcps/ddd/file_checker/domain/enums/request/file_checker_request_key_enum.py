from enum import StrEnum
from typing import final


@final
class FileCheckerRequestKeyEnum(StrEnum):
    """Request dictionary keys for file checker DTOs."""

    FILE_PATH_OR_URL = "file_path_or_url"
    ALGORITHM = "algorithm"
