from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class SearchProjectsResultDto:
    """Result DTO for project search."""

    projects: list[dict]
    total: int

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        projects = list(primitives.get("projects", []))
        return cls(
            projects=projects,
            total=int(primitives.get("total", len(projects))),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "projects": self.projects,
            "total": self.total,
        }
