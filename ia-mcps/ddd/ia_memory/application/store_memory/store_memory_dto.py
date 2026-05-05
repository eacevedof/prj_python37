from dataclasses import dataclass
from typing import Any

from ddd.ia_memory.domain.enums import MemoryTypeEnum


@dataclass(frozen=True)
class StoreMemoryDto:
    project: str
    memory_type: MemoryTypeEnum
    content: str
    paths: list[str] | None = None
    metadata: dict[str, Any] | None = None
