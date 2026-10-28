from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class PushBranchDto:
    """Input DTO for pushing a branch to a remote using a PAT."""

    repo_path: str
    branch: str
    remote: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        remote = primitives.get("remote")
        return cls(
            repo_path=str(primitives.get("repo_path", "")).strip(),
            branch=str(primitives.get("branch", "")).strip(),
            remote=str(remote).strip() if remote else None,
        )
