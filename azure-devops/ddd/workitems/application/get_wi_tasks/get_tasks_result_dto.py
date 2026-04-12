from dataclasses import dataclass, field
from typing import Self, Any

from ddd.workitems.application.get_wi_tasks.task_list_item_dto import TaskListItemDto


@dataclass(frozen=True, slots=True)
class GetTasksResultDto:
    """Output DTO containing queried work items list."""

    tasks: list[TaskListItemDto] = field(default_factory=list)
    total: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        tasks_primitives = primitives.get("tasks", [])
        tasks = [TaskListItemDto.from_primitives(t) for t in tasks_primitives]
        return cls(
            tasks=tasks,
            total=int(primitives.get("total", len(tasks))),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "tasks": [task.to_dict() for task in self.tasks],
            "total": self.total,
        }
