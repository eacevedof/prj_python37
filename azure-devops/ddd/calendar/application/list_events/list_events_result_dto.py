from dataclasses import dataclass, field
from typing import Self, Any

from ddd.calendar.application.list_events.event_item_dto import EventItemDto


@dataclass(frozen=True, slots=True)
class ListEventsResultDto:
    """Output DTO containing list of calendar events."""

    items: list[EventItemDto] = field(default_factory=list)
    user_id: str = ""
    total: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        items_primitives = primitives.get("items", [])
        items = [EventItemDto.from_primitives(item) for item in items_primitives]
        return cls(
            items=items,
            user_id=str(primitives.get("user_id", "")),
            total=int(primitives.get("total", len(items))),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "items": [item.to_dict() for item in self.items],
            "user_id": self.user_id,
            "total": self.total,
        }
