from dataclasses import dataclass
from typing import Self


@dataclass(frozen=True, slots=True)
class VerifyFileSignatureResultDto:
    """Result DTO for file signature verification."""

    is_valid: bool
    actual_hash: str
    expected_hash: str
    algorithm: str
    file_path: str

    @classmethod
    def from_primitives(cls, primitives: dict) -> Self:
        return cls(
            is_valid=bool(primitives.get("is_valid", False)),
            actual_hash=str(primitives.get("actual_hash", "")),
            expected_hash=str(primitives.get("expected_hash", "")),
            algorithm=str(primitives.get("algorithm", "")),
            file_path=str(primitives.get("file_path", "")),
        )
