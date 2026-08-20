from dataclasses import dataclass
from typing import Any, Self


@dataclass(frozen=True, slots=True)
class SearchMemoryResultDto:
    source: str
    project: str
    query: str
    chunks_found: int
    results: list[dict]

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            source=primitives.get("source", ""),
            project=primitives.get("project", ""),
            query=primitives.get("query", ""),
            chunks_found=primitives.get("chunks_found", 0),
            results=primitives.get("results", []),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "source": self.source,
            "project": self.project,
            "query": self.query,
            "chunks_found": self.chunks_found,
            "results": self.results,
        }

    def to_primitives(self) -> dict[str, Any]:
        return self.to_dict()
