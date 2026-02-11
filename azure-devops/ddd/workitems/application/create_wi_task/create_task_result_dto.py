from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class CreateTaskResultDto:
    id: int
    title: str
    url: str
    epic_id: int
    project: str
    due_date: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            id=int(primitives.get("id", 0)),
            title=str(primitives.get("title", "")).strip(),
            url=str(primitives.get("url", "")).strip(),
            epic_id=int(primitives.get("epic_id", 0)),
            project=str(primitives.get("project", "")).strip(),
            due_date=str(primitives.get("due_date", "")).strip(),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.id,
            "title": self.title,
            "url": self.url,
            "epic_id": self.epic_id,
            "project": self.project,
            "due_date": self.due_date,
        }
