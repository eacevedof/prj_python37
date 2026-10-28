from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class CreateIntegrationBranchResultDto:
    """Output DTO describing a created integration branch."""

    branch: str = ""
    base_branch: str = ""
    task_id: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            branch=str(primitives.get("branch", "")),
            base_branch=str(primitives.get("base_branch", "")),
            task_id=int(primitives.get("task_id", 0)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "branch": self.branch,
            "base_branch": self.base_branch,
            "task_id": self.task_id,
        }
