from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class CreateIntegrationBranchDto:
    """Input DTO for creating a task integration branch."""

    repo_path: str
    task_id: int
    title: str
    base_branch: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        base_branch = primitives.get("base_branch")
        return cls(
            repo_path=str(primitives.get("repo_path", "")).strip(),
            task_id=int(primitives.get("task_id", 0)),
            title=str(primitives.get("title", "")).strip(),
            base_branch=str(base_branch).strip() if base_branch else None,
        )
