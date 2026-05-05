from dataclasses import dataclass
from typing import Any


@dataclass(frozen=True)
class UpdateMemoryDto:
    chunk_id: str
    project: str
    content: str | None = None
    paths: list[str] | None = None
    metadata: dict[str, Any] | None = None
