from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class PushBranchResultDto:
    """Output DTO describing the outcome of a branch push."""

    pushed: bool = False
    remote: str = ""
    branch: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            pushed=bool(primitives.get("pushed", False)),
            remote=str(primitives.get("remote", "")),
            branch=str(primitives.get("branch", "")),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "pushed": self.pushed,
            "remote": self.remote,
            "branch": self.branch,
        }
