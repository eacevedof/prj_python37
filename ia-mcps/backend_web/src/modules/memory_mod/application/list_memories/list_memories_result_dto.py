from dataclasses import dataclass
from typing import Any, Self


@dataclass(frozen=True, slots=True)
class ListMemoriesResultDto:
    source: str
    project: str
    total_chunks: int
    chunks: list[dict]

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            source=primitives.get("source", ""),
            project=primitives.get("project", ""),
            total_chunks=primitives.get("total_chunks", 0),
            chunks=primitives.get("chunks", []),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "source": self.source,
            "project": self.project,
            "total_chunks": self.total_chunks,
            "chunks": self.chunks,
        }

    def to_primitives(self) -> dict[str, Any]:
        return self.to_dict()
