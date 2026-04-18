from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class CreateEventDto:
    """Input DTO for creating a calendar event."""

    user_id: str
    subject: str
    start_datetime: str
    end_datetime: str
    time_zone: str = "UTC"
    body: str | None = None
    location: str | None = None
    attendees: list[str] = field(default_factory=list)
    is_all_day: bool = False
    sensitivity: str = "normal"

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        attendees_raw = primitives.get("attendees")
        attendees: list[str] = []
        if isinstance(attendees_raw, list):
            attendees = [str(a).strip() for a in attendees_raw if a]
        elif isinstance(attendees_raw, str) and attendees_raw.strip():
            attendees = [a.strip() for a in attendees_raw.split(",") if a.strip()]

        body = primitives.get("body")
        if body is not None:
            body = str(body).strip() or None

        location = primitives.get("location")
        if location is not None:
            location = str(location).strip() or None

        return cls(
            user_id=str(primitives.get("user_id", "")).strip(),
            subject=str(primitives.get("subject", "")).strip(),
            start_datetime=str(primitives.get("start_datetime", "")).strip(),
            end_datetime=str(primitives.get("end_datetime", "")).strip(),
            time_zone=str(primitives.get("time_zone", "UTC")).strip(),
            body=body,
            location=location,
            attendees=attendees,
            is_all_day=bool(primitives.get("is_all_day", False)),
            sensitivity=str(primitives.get("sensitivity", "normal")).strip(),
        )
