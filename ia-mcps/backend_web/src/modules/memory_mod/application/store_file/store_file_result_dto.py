from dataclasses import dataclass
from typing import Any, Self


@dataclass(frozen=True, slots=True)
class StoreFileResultDto:
    source: str
    project: str
    file: str
    chunks_stored: int
    chunks: list[dict]

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            source=primitives.get("source", ""),
            project=primitives.get("project", ""),
            file=primitives.get("file", ""),
            chunks_stored=primitives.get("chunks_stored", 0),
            chunks=primitives.get("chunks", []),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "source": self.source,
            "project": self.project,
            "file": self.file,
            "chunks_stored": self.chunks_stored,
            "chunks": self.chunks,
        }

    def to_primitives(self) -> dict[str, Any]:
        return self.to_dict()
