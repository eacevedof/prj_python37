import hashlib
from pathlib import Path
from typing import Self, final

from ddd.file_checker.domain.exceptions.file_checker_exception import FileCheckerException
from ddd.shared.infrastructure.components.logger import Logger

_CHUNK_SIZE = 65536  # 64 KB — balances memory usage and I/O calls for large files


@final
class FileHashReaderRepository:
    """Repository that computes the hash of a file on disk."""

    _instance: "FileHashReaderRepository | None" = None

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def __init__(self) -> None:
        self._logger = Logger.get_instance()

    def get_hex_digest(self, file_path: str, algorithm: str) -> str:
        """
        Computes the hex digest of a file using the given algorithm.

        Args:
            file_path: Absolute or relative path to the file.
            algorithm: Hash algorithm name (md5, sha1, sha256, sha512).

        Returns:
            str: Lowercase hex digest string.

        Raises:
            FileCheckerException: If the file cannot be read or the algorithm is unsupported.
        """
        path = Path(file_path)

        if not path.exists():
            FileCheckerException.bad_request_custom(
                f"FileHashReaderRepository: file not found: {file_path}"
            )

        if not path.is_file():
            FileCheckerException.bad_request_custom(
                f"FileHashReaderRepository: path is not a file: {file_path}"
            )

        try:
            hasher = hashlib.new(algorithm)
        except ValueError:
            FileCheckerException.bad_request_custom(
                f"FileHashReaderRepository: unsupported algorithm '{algorithm}'"
            )

        try:
            with open(path, "rb") as f:
                for chunk in iter(lambda: f.read(_CHUNK_SIZE), b""):
                    hasher.update(chunk)
        except OSError as exc:
            self._logger.log_error(
                "FileHashReaderRepository",
                f"Could not read file: {file_path}",
                {"error": str(exc)},
            )
            FileCheckerException.unexpected_custom(
                f"FileHashReaderRepository: could not read file: {file_path}"
            )

        return hasher.hexdigest()
