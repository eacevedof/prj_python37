import re
from dataclasses import dataclass
from typing import Self, Any

from ddd.shared.infrastructure.repositories.environment_reader_raw_repository import EnvironmentReaderRawRepository
from ddd.workitems.domain.enums.work_item_type_enum import WorkItemTypeEnum


# Valid work item types for this operation
_VALID_TYPES = {t.value.lower(): t.value for t in [
    WorkItemTypeEnum.TASK,
    WorkItemTypeEnum.ISSUE,
    WorkItemTypeEnum.EPIC,
    WorkItemTypeEnum.BUG,
]}


@dataclass(frozen=True, slots=True)
class CreateWorkItemDto:
    """Input DTO for creating a standalone work item (Task, Issue, Epic, Bug)."""

    project: str
    work_item_type: str
    title: str
    description: str = ""
    assigned_to: str = ""
    tags: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        project = str(primitives.get("project", "")).strip()
        if not project:
            project = EnvironmentReaderRawRepository.get_instance().get_app_default_project()

        raw_type = str(primitives.get("work_item_type", "task")).strip().lower()
        work_item_type = _VALID_TYPES.get(raw_type, WorkItemTypeEnum.TASK.value)

        return cls(
            project=project,
            work_item_type=work_item_type,
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

    @staticmethod
    def get_valid_types() -> list[str]:
        """Return list of valid work item types."""
        return list(_VALID_TYPES.values())
