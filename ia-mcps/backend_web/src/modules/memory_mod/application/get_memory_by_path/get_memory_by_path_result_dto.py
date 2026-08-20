from dataclasses import dataclass
from typing import Any, Self


@dataclass(frozen=True, slots=True)
class GetMemoryByPathResultDto:
    project: str
    file_path: str
    total_chunks: int
    chunks: list[dict]

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            project=primitives.get("project", ""),
            file_path=primitives.get("file_path", ""),
            total_chunks=primitives.get("total_chunks", 0),
            chunks=primitives.get("chunks", []),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "project": self.project,
            "file_path": self.file_path,
            "total_chunks": self.total_chunks,
            "chunks": self.chunks,
        }

    def to_primitives(self) -> dict[str, Any]:
        return self.to_dict()
