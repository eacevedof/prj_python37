from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class EventItemDto:
    """DTO representing a calendar event item."""

    id: str
    subject: str
    start_datetime: str
    end_datetime: str
    time_zone: str
    location: str
    is_all_day: bool
    organizer: str
    web_link: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        start = primitives.get("start", {})
        end = primitives.get("end", {})
        location = primitives.get("location", {})
        organizer = primitives.get("organizer", {})
        organizer_email = organizer.get("emailAddress", {})

        return cls(
            id=str(primitives.get("id", "")),
            subject=str(primitives.get("subject", "")),
            start_datetime=str(start.get("dateTime", "")),
            end_datetime=str(end.get("dateTime", "")),
            time_zone=str(start.get("timeZone", "UTC")),
            location=str(location.get("displayName", "")),
            is_all_day=bool(primitives.get("isAllDay", False)),
            organizer=str(organizer_email.get("address", "")),
            web_link=str(primitives.get("webLink", "")),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.id,
            "subject": self.subject,
            "start_datetime": self.start_datetime,
            "end_datetime": self.end_datetime,
            "time_zone": self.time_zone,
            "location": self.location,
            "is_all_day": self.is_all_day,
            "organizer": self.organizer,
            "web_link": self.web_link,
        }
