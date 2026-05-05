from dataclasses import dataclass

from ddd.ia_memory.domain.enums import MemoryTypeEnum


@dataclass(frozen=True)
class SearchMemoryDto:
    project: str
    query: str
    limit: int = 5
    memory_type: MemoryTypeEnum | None = None
