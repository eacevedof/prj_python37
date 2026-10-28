from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class ListEventsResultDto:
    """Output DTO containing list of calendar events."""

    items: list[dict[str, Any]] = field(default_factory=list)
    user_id: str = ""
    total: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        items_primitives = primitives.get("items", [])
        items = [cls._to_event_item(item) for item in items_primitives]
        return cls(
            items=items,
            user_id=str(primitives.get("user_id", "")),
            total=int(primitives.get("total", len(items))),
        )

    @staticmethod
    def _to_event_item(primitives: dict[str, Any]) -> dict[str, Any]:
        start = primitives.get("start", {})
        end = primitives.get("end", {})
        location = primitives.get("location", {})
        organizer = primitives.get("organizer", {})
        organizer_email = organizer.get("emailAddress", {})

        return {
            "id": str(primitives.get("id", "")),
            "subject": str(primitives.get("subject", "")),
            "start_datetime": str(start.get("dateTime", "")),
            "end_datetime": str(end.get("dateTime", "")),
            "time_zone": str(start.get("timeZone", "UTC")),
            "location": str(location.get("displayName", "")),
            "is_all_day": bool(primitives.get("isAllDay", False)),
            "organizer": str(organizer_email.get("address", "")),
            "web_link": str(primitives.get("webLink", "")),
        }

    def to_dict(self) -> dict[str, Any]:
        return {
            "items": self.items,
            "user_id": self.user_id,
            "total": self.total,
        }
