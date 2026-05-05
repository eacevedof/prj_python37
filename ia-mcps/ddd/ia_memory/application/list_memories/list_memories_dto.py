from dataclasses import dataclass

from ddd.ia_memory.domain.enums import MemoryTypeEnum


@dataclass(frozen=True)
class ListMemoriesDto:
    project: str
    memory_type: MemoryTypeEnum | None = None
    stale_only: bool = False
