from dataclasses import dataclass

from ddd.ia_memory.domain.enums import MemoryTypeEnum


@dataclass(frozen=True, slots=True)
class GetMemoryByTypeDto:
    project: str
    memory_type: MemoryTypeEnum
