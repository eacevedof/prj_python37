from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class UpdateEventDto:
    """Input DTO for updating a calendar event."""

    user_id: str
    event_id: str
    subject: str | None = None
    start_datetime: str | None = None
    end_datetime: str | None = None
    time_zone: str | None = None
    body: str | None = None
    location: str | None = None
    attendees: list[str] | None = None
    is_all_day: bool | None = None
    sensitivity: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        subject = primitives.get("subject")
        if subject is not None:
            subject = str(subject).strip() or None

        start_datetime = primitives.get("start_datetime")
        if start_datetime is not None:
            start_datetime = str(start_datetime).strip() or None

        end_datetime = primitives.get("end_datetime")
        if end_datetime is not None:
            end_datetime = str(end_datetime).strip() or None

        time_zone = primitives.get("time_zone")
        if time_zone is not None:
            time_zone = str(time_zone).strip() or None

        body = primitives.get("body")
        if body is not None:
            body = str(body).strip() or None

        location = primitives.get("location")
        if location is not None:
            location = str(location).strip() or None

        attendees_raw = primitives.get("attendees")
        attendees: list[str] | None = None
        if attendees_raw is not None:
            if isinstance(attendees_raw, list):
                attendees = [str(a).strip() for a in attendees_raw if a]
            elif isinstance(attendees_raw, str) and attendees_raw.strip():
                attendees = [a.strip() for a in attendees_raw.split(",") if a.strip()]

        is_all_day = primitives.get("is_all_day")
        if is_all_day is not None:
            is_all_day = bool(is_all_day)

        sensitivity = primitives.get("sensitivity")
        if sensitivity is not None:
            sensitivity = str(sensitivity).strip() or None

        return cls(
            user_id=str(primitives.get("user_id", "")).strip(),
            event_id=str(primitives.get("event_id", "")).strip(),
            subject=subject,
            start_datetime=start_datetime,
            end_datetime=end_datetime,
            time_zone=time_zone,
            body=body,
            location=location,
            attendees=attendees,
            is_all_day=is_all_day,
            sensitivity=sensitivity,
        )
