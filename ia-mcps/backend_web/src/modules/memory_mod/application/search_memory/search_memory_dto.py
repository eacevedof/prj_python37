from dataclasses import dataclass

from src.modules.memory_mod.domain.enums import MemoryTypeEnum


@dataclass(frozen=True, slots=True)
class SearchMemoryDto:
    project: str
    query: str
    limit: int = 5
    memory_type: MemoryTypeEnum | None = None
