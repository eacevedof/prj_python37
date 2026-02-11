from dataclasses import dataclass, field
from typing import Self, Any

from ddd.shared.infrastructure.repositories.environment_reader_raw_repository import EnvironmentReaderRawRepository


@dataclass(frozen=True, slots=True)
class CreateEpicDto:
    project: str
    title: str
    description: str = ""
    departments: list[str] = field(default_factory=list)
    assigned_to: str = ""
    tags: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        project = str(primitives.get("project", "")).strip()
        if not project:
            project = EnvironmentReaderRawRepository.get_instance().get_app_default_project()

        return cls(
            project=project,
            title=str(primitives.get("title", "")).strip(),
            description=str(primitives.get("description", "")).strip(),
            departments=primitives.get("departments", []),
            assigned_to=str(primitives.get("assigned_to", "")).strip(),
            tags=str(primitives.get("tags", "")).strip(),
        )
