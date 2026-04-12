from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class SearchWorkItemsDto:
    """Input DTO for searching work items by text across the organization."""

    search_text: str
    limit: int = 25
    work_item_type: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            search_text=str(primitives.get("search_text", "")).strip(),
            limit=int(primitives.get("limit", 25)),
            work_item_type=str(primitives.get("work_item_type", "")).strip(),
        )
