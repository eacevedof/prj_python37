from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class TaskListItemDto:
    """DTO representing a single work item in a list."""

    id: int
    work_item_type: str
    title: str
    state: str
    assigned_to: str
    due_date: str
    url: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            id=int(primitives.get("id", 0)),
            work_item_type=str(primitives.get("work_item_type", "")).strip(),
            title=str(primitives.get("title", "")).strip(),
            state=str(primitives.get("state", "")).strip(),
            assigned_to=str(primitives.get("assigned_to", "")).strip(),
            due_date=str(primitives.get("due_date", "")).strip(),
            url=str(primitives.get("url", "")).strip(),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.id,
            "type": self.work_item_type,
            "title": self.title,
            "state": self.state,
            "assigned_to": self.assigned_to,
            "due_date": self.due_date,
            "url": self.url,
        }
