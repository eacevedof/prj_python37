import os
from datetime import datetime
from typing import Self, final

from ddd.file_checker.domain.enums import FileCheckerResponseKeyEnum


@final
class FileMetadataReaderFileRepository:
    """Reader repository for file system metadata."""

    _instance: "FileMetadataReaderFileRepository | None" = None

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def __init__(self) -> None:
        pass

    def get_metadata(self, file_path: str) -> dict:
        """Get file size and last modified timestamp.

        Args:
            file_path: Path to the file on disk.

        Returns:
            Dict with FILE_SIZE (int) and LAST_MODIFIED (ISO 8601 string).

        Raises:
            OSError: If file does not exist or cannot be stat'd.
        """
        stat_info = os.stat(file_path)
        file_size = stat_info.st_size
        last_modified = datetime.fromtimestamp(stat_info.st_mtime).isoformat()

        return {
            FileCheckerResponseKeyEnum.FILE_SIZE: file_size,
            FileCheckerResponseKeyEnum.LAST_MODIFIED: last_modified,
        }
