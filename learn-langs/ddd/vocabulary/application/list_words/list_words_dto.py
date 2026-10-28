"""DTO de entrada para listar palabras."""

from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class ListWordsDto:
    """Input DTO para listar palabras."""

    search: str = ""
    word_type: str | None = None
    tags: list[str] = field(default_factory=list)
    limit: int = 100
    offset: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            search=str(primitives.get("search", "") or "").strip(),
            word_type=primitives.get("word_type"),
            tags=list(primitives.get("tags", []) or []),
            limit=int(primitives.get("limit", 100)),
            offset=int(primitives.get("offset", 0)),
        )
