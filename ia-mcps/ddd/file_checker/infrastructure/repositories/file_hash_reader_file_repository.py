import hashlib
from pathlib import Path
from typing import Self, final

from ddd.shared.infrastructure.components.logger import Logger
from ddd.file_checker.domain.exceptions.file_checker_exception import FileCheckerException
from ddd.file_checker.domain.enums.hash.file_checker_hash_constants_enum import FileCheckerHashConstantsEnum


@final
class FileHashReaderFileRepository:
    """Reader repository for file hashes (reads from filesystem)."""

    _logger: Logger
    _instance: "FileHashReaderFileRepository | None" = None

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()

        return cls._instance

    def __init__(self) -> None:
        self._logger = Logger.get_instance()

    def get_hex_digest(self, file_path: str, algorithm: str) -> str:
        """Compute the hex digest of a file.

        Args:
            file_path: Path to the file on disk.
            algorithm: Hash algorithm name (md5, sha1, sha256, sha512).

        Returns:
            Lowercase hex digest string.

        Raises:
            FileCheckerException: If file does not exist or is not a file.
            ValueError: If algorithm is unsupported.
            OSError: If the file cannot be read.
        """
        path = Path(file_path)

        if not path.exists():
            FileCheckerException.bad_request_custom(
                f"FileHashReaderFileRepository: file not found: {file_path}"
            )

        if not path.is_file():
            FileCheckerException.bad_request_custom(
                f"FileHashReaderFileRepository: path is not a file: {file_path}"
            )

        hasher = hashlib.new(algorithm)

        with open(path, "rb") as f:
            for chunk in iter(lambda: f.read(FileCheckerHashConstantsEnum.CHUNK_SIZE), b""):
                hasher.update(chunk)

        return hasher.hexdigest()
