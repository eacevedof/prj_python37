from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class AddHolidayResultDto:
    """Output DTO containing created holiday event details."""

    id: str
    title: str
    date: str
    calendar_name: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        start = primitives.get("start", {})

        return cls(
            id=str(primitives.get("id", "")),
            title=str(primitives.get("subject", "")),
            date=str(start.get("dateTime", ""))[:10],
            calendar_name=str(primitives.get("calendar_name", "")),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.id,
            "title": self.title,
            "date": self.date,
            "calendar_name": self.calendar_name,
        }
