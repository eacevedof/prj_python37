from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class CreateWorkItemResultDto:
    """Output DTO containing created work item details."""

    id: int
    work_item_type: str
    title: str
    url: str
    project: str
    due_date: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            id=int(primitives.get("id", 0)),
            work_item_type=str(primitives.get("work_item_type", "")),
            title=str(primitives.get("title", "")).strip(),
            url=str(primitives.get("url", "")).strip(),
            project=str(primitives.get("project", "")).strip(),
            due_date=str(primitives.get("due_date", "")).strip(),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.id,
            "work_item_type": self.work_item_type,
            "title": self.title,
            "url": self.url,
            "project": self.project,
            "due_date": self.due_date,
        }
