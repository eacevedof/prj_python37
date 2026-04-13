from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class DeleteFileResultDto:
    """Output DTO for file deletion result."""

    file_path: str
    deleted: bool

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            file_path=str(primitives.get("file_path", "")),
            deleted=bool(primitives.get("deleted", False)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "file_path": self.file_path,
            "deleted": self.deleted,
        }
