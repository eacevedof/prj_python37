from dataclasses import dataclass

from src.modules.memory_mod.domain.enums import MemoryTypeEnum


@dataclass(frozen=True, slots=True)
class GetMemoryByTypeDto:
    project: str
    memory_type: MemoryTypeEnum
