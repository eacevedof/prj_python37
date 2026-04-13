from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class SearchWorkItemDto:
    """Single work item from search results."""

    id: int
    title: str
    work_item_type: str
    state: str
    project: str
    assigned_to: str
    created_date: str
    changed_date: str
    url: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            id=primitives.get("id", 0),
            title=primitives.get("title", ""),
            work_item_type=primitives.get("work_item_type", ""),
            state=primitives.get("state", ""),
            project=primitives.get("project", ""),
            assigned_to=primitives.get("assigned_to", ""),
            created_date=primitives.get("created_date", ""),
            changed_date=primitives.get("changed_date", ""),
            url=primitives.get("url", ""),
        )


@dataclass(frozen=True, slots=True)
class SearchWorkItemsResultDto:
    """Output DTO containing work item search results."""

    items: list[SearchWorkItemDto] = field(default_factory=list)
    total: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        items_data = primitives.get("items", [])
        items = [SearchWorkItemDto.from_primitives(item) for item in items_data]
        return cls(
            items=items,
            total=primitives.get("total", len(items)),
        )
