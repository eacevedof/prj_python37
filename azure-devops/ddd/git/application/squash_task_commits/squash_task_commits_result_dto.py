from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class SquashTaskCommitsResultDto:
    """Output DTO describing the single commit produced by a squash."""

    commit_sha: str = ""
    message: str = ""
    squashed_count: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            commit_sha=str(primitives.get("commit_sha", "")),
            message=str(primitives.get("message", "")),
            squashed_count=int(primitives.get("squashed_count", 0)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "commit_sha": self.commit_sha,
            "message": self.message,
            "squashed_count": self.squashed_count,
        }
