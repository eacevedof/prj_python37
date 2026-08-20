from dataclasses import dataclass
from typing import Any, Self


@dataclass(frozen=True, slots=True)
class InitializeProjectResultDto:
    project_name: str
    total_chunks: int
    total_files_processed: int
    memory_types_indexed: dict[str, int]
    status: str
    message: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            project_name=primitives.get("project_name", ""),
            total_chunks=primitives.get("total_chunks", 0),
            total_files_processed=primitives.get("total_files_processed", 0),
            memory_types_indexed=primitives.get("memory_types_indexed", {}),
            status=primitives.get("status", ""),
            message=primitives.get("message", ""),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "project_name": self.project_name,
            "total_chunks": self.total_chunks,
            "total_files_processed": self.total_files_processed,
            "memory_types_indexed": self.memory_types_indexed,
            "status": self.status,
            "message": self.message,
        }

    def to_primitives(self) -> dict[str, Any]:
        return self.to_dict()
