from dataclasses import dataclass
from typing import Any, Self


@dataclass(frozen=True, slots=True)
class UpdateMemoryResultDto:
    id: str
    project: str
    content: str
    metadata: dict[str, Any]
    source: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            id=primitives.get("id", ""),
            project=primitives.get("project", ""),
            content=primitives.get("content", ""),
            metadata=primitives.get("metadata", {}),
            source=primitives.get("source", ""),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.id,
            "project": self.project,
            "content": self.content,
            "metadata": self.metadata,
            "source": self.source,
        }

    def to_primitives(self) -> dict[str, Any]:
        return self.to_dict()
