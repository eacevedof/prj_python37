from dataclasses import dataclass
from typing import Any, Self


@dataclass(frozen=True, slots=True)
class CheckFreshnessResultDto:
    source: str
    project: str
    total_chunks: int
    fresh: int
    stale: int
    unknown: int
    chunks: list[dict]

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            source=primitives.get("source", ""),
            project=primitives.get("project", ""),
            total_chunks=primitives.get("total_chunks", 0),
            fresh=primitives.get("fresh", 0),
            stale=primitives.get("stale", 0),
            unknown=primitives.get("unknown", 0),
            chunks=primitives.get("chunks", []),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "source": self.source,
            "project": self.project,
            "total_chunks": self.total_chunks,
            "fresh": self.fresh,
            "stale": self.stale,
            "unknown": self.unknown,
            "chunks": self.chunks,
        }

    def to_primitives(self) -> dict[str, Any]:
        return self.to_dict()
