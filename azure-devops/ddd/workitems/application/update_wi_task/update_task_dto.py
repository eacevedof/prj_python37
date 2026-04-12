from dataclasses import dataclass
from typing import Self, Any

from ddd.shared.infrastructure.repositories.environment_reader_raw_repository import EnvironmentReaderRawRepository


@dataclass(frozen=True, slots=True)
class UpdateTaskDto:
    """Input DTO for updating a Task work item."""

    project: str
    task_id: int
    state: str | None = None
    assigned_to: str | None = None
    title: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        project = str(primitives.get("project", "")).strip()
        if not project:
            project = EnvironmentReaderRawRepository.get_instance().get_app_default_project()

        return cls(
            project=project,
            task_id=int(primitives.get("task_id", 0)),
            state=primitives.get("state"),
            assigned_to=primitives.get("assigned_to"),
            title=primitives.get("title"),
        )
