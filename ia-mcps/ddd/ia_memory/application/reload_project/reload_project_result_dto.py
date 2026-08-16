from dataclasses import dataclass
from typing import Any, Self


@dataclass(frozen=True, slots=True)
class ReloadProjectResultDto:
    project_name: str
    chunks_deleted: int
    chunks_created: int
    status: str
    message: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            project_name=primitives.get("project_name", ""),
            chunks_deleted=primitives.get("chunks_deleted", 0),
            chunks_created=primitives.get("chunks_created", 0),
            status=primitives.get("status", ""),
            message=primitives.get("message", ""),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "project_name": self.project_name,
            "chunks_deleted": self.chunks_deleted,
            "chunks_created": self.chunks_created,
            "status": self.status,
            "message": self.message,
        }

    def to_primitives(self) -> dict[str, Any]:
        return self.to_dict()
