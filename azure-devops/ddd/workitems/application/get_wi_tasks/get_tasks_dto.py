from dataclasses import dataclass
from typing import Self, Any

from ddd.shared.infrastructure.repositories.environment_reader_raw_repository import EnvironmentReaderRawRepository


@dataclass(frozen=True, slots=True)
class GetTasksDto:
    """Input DTO for querying work items with filters."""

    project: str
    epic_id: int | None = None
    state: str | None = None
    assigned_to: str | None = None
    work_item_type: str | None = None
    limit: int = 50

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        project = str(primitives.get("project", "")).strip()
        if not project:
            project = EnvironmentReaderRawRepository.get_instance().get_app_default_project()

        epic_id = primitives.get("epic_id")
        return cls(
            project=project,
            epic_id=int(epic_id) if epic_id else None,
            state=primitives.get("state"),
            assigned_to=primitives.get("assigned_to"),
            work_item_type=primitives.get("work_item_type"),
            limit=int(primitives.get("limit", 50)),
        )
