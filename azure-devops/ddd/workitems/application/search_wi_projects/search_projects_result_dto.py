from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class ProjectDto:
    """DTO representing a single project."""

    id: str
    name: str
    description: str
    url: str
    state: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            id=str(primitives.get("id", "")),
            name=str(primitives.get("name", "")),
            description=str(primitives.get("description", "")),
            url=str(primitives.get("url", "")),
            state=str(primitives.get("state", "")),
        )


@dataclass(frozen=True, slots=True)
class SearchProjectsResultDto:
    """Result DTO for project search."""

    projects: list[ProjectDto]
    total: int

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        projects_data = primitives.get("projects", [])
        projects = [ProjectDto.from_primitives(p) for p in projects_data]
        return cls(
            projects=projects,
            total=int(primitives.get("total", len(projects))),
        )
