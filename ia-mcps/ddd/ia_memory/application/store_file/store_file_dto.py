from dataclasses import dataclass

from ddd.ia_memory.domain.enums import MemoryTypeEnum


@dataclass(frozen=True)
class StoreFileDto:
    project: str
    file_path: str
    memory_type: MemoryTypeEnum = MemoryTypeEnum.DOCUMENTATION
