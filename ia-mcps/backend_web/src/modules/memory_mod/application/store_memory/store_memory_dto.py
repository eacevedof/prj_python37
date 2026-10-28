from dataclasses import dataclass
from typing import Any

from src.modules.memory_mod.domain.enums import MemoryTypeEnum


@dataclass(frozen=True, slots=True)
class StoreMemoryDto:
    project: str
    memory_type: MemoryTypeEnum
    content: str
    paths: list[str] | None = None
    metadata: dict[str, Any] | None = None
