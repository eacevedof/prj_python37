from dataclasses import dataclass


@dataclass(frozen=True, slots=True)
class DeleteMemoryDto:
    chunk_id: str
    project: str
