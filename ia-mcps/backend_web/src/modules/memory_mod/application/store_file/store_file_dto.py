from dataclasses import dataclass

from src.modules.memory_mod.domain.enums import MemoryTypeEnum


@dataclass(frozen=True, slots=True)
class StoreFileDto:
    project: str
    file_path: str
    memory_type: MemoryTypeEnum = MemoryTypeEnum.DOCUMENTATION
