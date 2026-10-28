from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class SearchWorkItemsResultDto:
    """Output DTO containing work item search results."""

    items: list[dict] = field(default_factory=list)
    total: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        items = list(primitives.get("items", []))
        return cls(
            items=items,
            total=primitives.get("total", len(items)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "items": self.items,
            "total": self.total,
        }
