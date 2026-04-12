from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class SearchProjectsDto:
    """Input DTO for searching projects by text."""

    search_text: str
    limit: int = 25

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            search_text=str(primitives.get("search_text", "")).strip().lower(),
            limit=int(primitives.get("limit", 25)),
        )
