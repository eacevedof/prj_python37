from dataclasses import dataclass
from typing import Any, Self


@dataclass(frozen=True, slots=True)
class GetMemoryByMetadataResultDto:
    project: str
    metadata_key: str
    metadata_value: str
    total_chunks: int
    chunks: list[dict]

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            project=primitives.get("project", ""),
            metadata_key=primitives.get("metadata_key", ""),
            metadata_value=primitives.get("metadata_value", ""),
            total_chunks=primitives.get("total_chunks", 0),
            chunks=primitives.get("chunks", []),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "project": self.project,
            "metadata_key": self.metadata_key,
            "metadata_value": self.metadata_value,
            "total_chunks": self.total_chunks,
            "chunks": self.chunks,
        }

    def to_primitives(self) -> dict[str, Any]:
        return self.to_dict()
