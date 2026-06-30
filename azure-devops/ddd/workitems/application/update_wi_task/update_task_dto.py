from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class UpdateTaskDto:
    """Input DTO for updating a Task work item."""

    project: str
    task_id: int
    state: str | None = None
    assigned_to: str | None = None
    title: str | None = None
    description: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        project = str(primitives.get("project", "")).strip()

        return cls(
            project=project,
            task_id=int(primitives.get("task_id", 0)),
            state=primitives.get("state"),
            assigned_to=primitives.get("assigned_to"),
            title=primitives.get("title"),
            description=primitives.get("description"),
        )
