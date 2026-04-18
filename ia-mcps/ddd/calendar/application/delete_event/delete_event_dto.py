from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class DeleteEventDto:
    """Input DTO for deleting a calendar event."""

    user_id: str
    event_id: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            user_id=str(primitives.get("user_id", "")).strip(),
            event_id=str(primitives.get("event_id", "")).strip(),
        )
