from dataclasses import dataclass


@dataclass(frozen=True)
class DeleteMemoryDto:
    chunk_id: str
    project: str
