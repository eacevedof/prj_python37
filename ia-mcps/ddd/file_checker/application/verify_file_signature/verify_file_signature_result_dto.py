from dataclasses import dataclass
from typing import Any, Self

from ddd.file_checker.domain.enums import (
    FileCheckerResponseKeyEnum,
)


@dataclass(frozen=True, slots=True)
class VerifyFileSignatureResultDto:
    """Result DTO returned by VerifyFileSignatureService.

    Immutable container for verification results. Access fields directly.

    Attributes:
        is_valid: Whether the file hash matches the expected hash.
        actual_hash: The computed hash of the file (lowercase hex).
        expected_hash: The expected hash provided as input (lowercase hex).
        algorithm: The hash algorithm used (e.g., sha256).
        file_path: The path to the file that was verified.
    """

    is_valid: bool
    actual_hash: str
    expected_hash: str
    algorithm: str
    file_path: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        """Construct from service computation result.

        Args:
            primitives: Dict with is_valid, actual_hash, expected_hash, algorithm, file_path.

        Returns:
            VerifyFileSignatureResultDto instance.
        """
        return cls(
            is_valid=bool(primitives.get(FileCheckerResponseKeyEnum.IS_VALID, False)),
            actual_hash=str(primitives.get(FileCheckerResponseKeyEnum.ACTUAL_HASH, "")),
            expected_hash=str(primitives.get(FileCheckerResponseKeyEnum.EXPECTED_HASH, "")),
            algorithm=str(primitives.get(FileCheckerResponseKeyEnum.ALGORITHM, "")),
            file_path=str(primitives.get(FileCheckerResponseKeyEnum.FILE_PATH, "")),
        )

    def to_dict(self) -> dict[str, Any]:
        """Serialize to dict for JSON response or template rendering."""
        return {
            FileCheckerResponseKeyEnum.IS_VALID: self.is_valid,
            FileCheckerResponseKeyEnum.ACTUAL_HASH: self.actual_hash,
            FileCheckerResponseKeyEnum.EXPECTED_HASH: self.expected_hash,
            FileCheckerResponseKeyEnum.ALGORITHM: self.algorithm,
            FileCheckerResponseKeyEnum.FILE_PATH: self.file_path,
        }

    def to_primitives(self) -> dict[str, Any]:
        """Alias for to_dict() — serialize to primitives dict."""
        return self.to_dict()
