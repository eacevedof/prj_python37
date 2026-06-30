from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class GetWorkItemDetailDto:
    """Input DTO for getting work item detail by ID."""

    work_item_id: int
    project: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        project = str(primitives.get("project", "")).strip()

        return cls(
            work_item_id=int(primitives.get("work_item_id", 0)),
            project=project,
        )
