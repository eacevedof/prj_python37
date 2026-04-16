from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class GetEventResultDto:
    """Output DTO containing a single calendar event details."""

    id: str = ""
    subject: str = ""
    body: str = ""
    start_datetime: str = ""
    end_datetime: str = ""
    time_zone: str = "UTC"
    location: str = ""
    is_all_day: bool = False
    organizer: str = ""
    attendees: list[str] = field(default_factory=list)
    sensitivity: str = "normal"
    web_link: str = ""
    created_datetime: str = ""
    last_modified_datetime: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        start = primitives.get("start", {})
        end = primitives.get("end", {})
        location = primitives.get("location", {})
        body = primitives.get("body", {})
        organizer = primitives.get("organizer", {})
        organizer_email = organizer.get("emailAddress", {})

        attendees_raw = primitives.get("attendees", [])
        attendees = [
            att.get("emailAddress", {}).get("address", "")
            for att in attendees_raw
            if att.get("emailAddress", {}).get("address")
        ]

        return cls(
            id=str(primitives.get("id", "")),
            subject=str(primitives.get("subject", "")),
            body=str(body.get("content", "")),
            start_datetime=str(start.get("dateTime", "")),
            end_datetime=str(end.get("dateTime", "")),
            time_zone=str(start.get("timeZone", "UTC")),
            location=str(location.get("displayName", "")),
            is_all_day=bool(primitives.get("isAllDay", False)),
            organizer=str(organizer_email.get("address", "")),
            attendees=attendees,
            sensitivity=str(primitives.get("sensitivity", "normal")),
            web_link=str(primitives.get("webLink", "")),
            created_datetime=str(primitives.get("createdDateTime", "")),
            last_modified_datetime=str(primitives.get("lastModifiedDateTime", "")),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.id,
            "subject": self.subject,
            "body": self.body,
            "start_datetime": self.start_datetime,
            "end_datetime": self.end_datetime,
            "time_zone": self.time_zone,
            "location": self.location,
            "is_all_day": self.is_all_day,
            "organizer": self.organizer,
            "attendees": self.attendees,
            "sensitivity": self.sensitivity,
            "web_link": self.web_link,
            "created_datetime": self.created_datetime,
            "last_modified_datetime": self.last_modified_datetime,
        }
