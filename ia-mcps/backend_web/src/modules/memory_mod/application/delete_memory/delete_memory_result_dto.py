from dataclasses import dataclass
from typing import Any, Self


@dataclass(frozen=True, slots=True)
class DeleteMemoryResultDto:
    id: str
    project: str
    deleted: bool
    source: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            id=primitives.get("id", ""),
            project=primitives.get("project", ""),
            deleted=primitives.get("deleted", False),
            source=primitives.get("source", ""),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.id,
            "project": self.project,
            "deleted": self.deleted,
            "source": self.source,
        }

    def to_primitives(self) -> dict[str, Any]:
        return self.to_dict()
