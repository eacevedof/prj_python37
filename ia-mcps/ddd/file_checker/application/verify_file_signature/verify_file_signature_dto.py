from dataclasses import dataclass
from typing import Self

from ddd.file_checker.domain.enums import FileCheckerHashAlgorithmEnum


@dataclass(frozen=True, slots=True)
class VerifyFileSignatureDto:
    """DTO for parameterizing file signature verification."""

    file_path: str
    expected_hash: str
    algorithm: str = FileCheckerHashAlgorithmEnum.SHA256

    @classmethod
    def from_primitives(cls, primitives: dict) -> Self:
        file_path = str(primitives.get("file_path", "")).strip()
        expected_hash = str(primitives.get("expected_hash", "")).strip().lower()
        algorithm = str(primitives.get("algorithm", FileCheckerHashAlgorithmEnum.SHA256)).strip().lower()

        return cls(
            file_path=file_path,
            expected_hash=expected_hash,
            algorithm=algorithm,
        )

    def __post_init__(self) -> None:
        if not self.file_path:
            raise ValueError("VerifyFileSignatureDto: file_path cannot be empty")
        if not self.expected_hash:
            raise ValueError("VerifyFileSignatureDto: expected_hash cannot be empty")
