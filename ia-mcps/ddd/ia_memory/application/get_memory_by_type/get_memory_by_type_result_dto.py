from dataclasses import dataclass
from typing import Any, Self


@dataclass(frozen=True, slots=True)
class GetMemoryByTypeResultDto:
    project: str
    memory_type: str
    total_chunks: int
    chunks: list[dict]

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            project=primitives.get("project", ""),
            memory_type=primitives.get("memory_type", ""),
            total_chunks=primitives.get("total_chunks", 0),
            chunks=primitives.get("chunks", []),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "project": self.project,
            "memory_type": self.memory_type,
            "total_chunks": self.total_chunks,
            "chunks": self.chunks,
        }

    def to_primitives(self) -> dict[str, Any]:
        return self.to_dict()
