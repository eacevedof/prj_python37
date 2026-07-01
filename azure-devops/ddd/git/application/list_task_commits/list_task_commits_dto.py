from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class ListTaskCommitsDto:
    """Input DTO for listing a task's commits between two branches."""

    repo_path: str
    task_id: int
    base_branch: str | None = None
    source_branch: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        base_branch = primitives.get("base_branch")
        source_branch = primitives.get("source_branch")
        return cls(
            repo_path=str(primitives.get("repo_path", "")).strip(),
            task_id=int(primitives.get("task_id", 0)),
            base_branch=str(base_branch).strip() if base_branch else None,
            source_branch=str(source_branch).strip() if source_branch else None,
        )
