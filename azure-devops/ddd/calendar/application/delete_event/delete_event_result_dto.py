from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class DeleteEventResultDto:
    """Output DTO containing delete operation result."""

    event_id: str
    deleted: bool

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            event_id=str(primitives.get("event_id", "")),
            deleted=bool(primitives.get("deleted", False)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "event_id": self.event_id,
            "deleted": self.deleted,
        }
