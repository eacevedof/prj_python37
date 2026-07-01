from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class ListTaskCommitsResultDto:
    """Output DTO containing a task's matched commits."""

    commits: list[dict[str, Any]] = field(default_factory=list)
    total: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        commits_primitives = primitives.get("commits", [])
        commits = [cls._to_commit(commit) for commit in commits_primitives]
        return cls(
            commits=commits,
            total=int(primitives.get("total", len(commits))),
        )

    @staticmethod
    def _to_commit(primitives: dict[str, Any]) -> dict[str, Any]:
        return {
            "sha": str(primitives.get("sha", "")),
            "subject": str(primitives.get("subject", "")),
        }

    def to_dict(self) -> dict[str, Any]:
        return {
            "commits": self.commits,
            "total": self.total,
        }
