from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class GetTasksResultDto:
    """Output DTO containing queried work items list."""

    tasks: list[dict] = field(default_factory=list)
    total: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        tasks = list(primitives.get("tasks", []))
        return cls(
            tasks=tasks,
            total=int(primitives.get("total", len(tasks))),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "tasks": [
                {
                    "id": int(task.get("id", 0)),
                    "type": str(task.get("work_item_type", "")).strip(),
                    "title": str(task.get("title", "")).strip(),
                    "state": str(task.get("state", "")).strip(),
                    "assigned_to": str(task.get("assigned_to", "")).strip(),
                    "due_date": str(task.get("due_date", "")).strip(),
                    "url": str(task.get("url", "")).strip(),
                }
                for task in self.tasks
            ],
            "total": self.total,
        }
