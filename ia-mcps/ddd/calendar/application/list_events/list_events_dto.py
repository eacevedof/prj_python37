from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class ListEventsDto:
    """Input DTO for listing calendar events."""

    user_id: str
    start_datetime: str | None = None
    end_datetime: str | None = None
    top: int = 50

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        user_id = str(primitives.get("user_id", "")).strip()

        start_datetime = primitives.get("start_datetime")
        if start_datetime is not None:
            start_datetime = str(start_datetime).strip() or None

        end_datetime = primitives.get("end_datetime")
        if end_datetime is not None:
            end_datetime = str(end_datetime).strip() or None

        top = int(primitives.get("top", 50))

        return cls(
            user_id=user_id,
            start_datetime=start_datetime,
            end_datetime=end_datetime,
            top=top,
        )
