from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class SquashTaskCommitsDto:
    """Input DTO for squashing a task's commits into a single commit."""

    repo_path: str
    task_id: int
    title: str
    source_branch: str
    integration_branch: str | None = None
    base_branch: str | None = None
    commit_type: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        integration_branch = primitives.get("integration_branch")
        base_branch = primitives.get("base_branch")
        commit_type = primitives.get("commit_type")
        return cls(
            repo_path=str(primitives.get("repo_path", "")).strip(),
            task_id=int(primitives.get("task_id", 0)),
            title=str(primitives.get("title", "")).strip(),
            source_branch=str(primitives.get("source_branch", "")).strip(),
            integration_branch=(
                str(integration_branch).strip() if integration_branch else None
            ),
            base_branch=str(base_branch).strip() if base_branch else None,
            commit_type=str(commit_type).strip() if commit_type else None,
        )
