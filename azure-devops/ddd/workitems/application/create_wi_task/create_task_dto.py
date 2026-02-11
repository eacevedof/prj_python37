import re
from dataclasses import dataclass
from typing import Self, Any

from ddd.shared.infrastructure.repositories.environment_reader_raw_repository import EnvironmentReaderRawRepository


@dataclass(frozen=True, slots=True)
class CreateTaskDto:
    project: str
    epic_id: int
    title: str
    description: str = ""
    assigned_to: str = ""
    tags: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        project = str(primitives.get("project", "")).strip()
        if not project:
            project = EnvironmentReaderRawRepository.get_instance().get_app_default_project()

        return cls(
            project=project,
            epic_id=int(primitives.get("epic_id", 0)),
            title=str(primitives.get("title", "")).strip(),
            description=str(primitives.get("description", "")).strip(),
            assigned_to=str(primitives.get("assigned_to", "")).strip(),
            tags=str(primitives.get("tags", "")).strip(),
        )

    def get_due_date_from_title(self) -> str:
        """Extract date from end of title: 'xxx yyy 2026-04-28' -> '2026-04-28'"""
        match = re.search(r"(\d{4}-\d{2}-\d{2})$", self.title.strip())
        if match:
            return match.group(1)
        return ""
