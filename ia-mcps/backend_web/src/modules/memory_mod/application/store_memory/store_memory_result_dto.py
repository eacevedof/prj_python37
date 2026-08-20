from dataclasses import dataclass
from typing import Any, Self


@dataclass(frozen=True, slots=True)
class StoreMemoryResultDto:
    id: str
    project: str
    type: str
    content: str
    metadata: dict[str, Any]
    source: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            id=primitives.get("id", ""),
            project=primitives.get("project", ""),
            type=primitives.get("type", ""),
            content=primitives.get("content", ""),
            metadata=primitives.get("metadata", {}),
            source=primitives.get("source", ""),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.id,
            "project": self.project,
            "type": self.type,
            "content": self.content,
            "metadata": self.metadata,
            "source": self.source,
        }

    def to_primitives(self) -> dict[str, Any]:
        return self.to_dict()
