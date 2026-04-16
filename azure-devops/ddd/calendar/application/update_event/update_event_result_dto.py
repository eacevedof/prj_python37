from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class UpdateEventResultDto:
    """Output DTO containing updated calendar event details."""

    id: str
    subject: str
    start_datetime: str
    end_datetime: str
    web_link: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        start = primitives.get("start", {})
        end = primitives.get("end", {})

        return cls(
            id=str(primitives.get("id", "")),
            subject=str(primitives.get("subject", "")),
            start_datetime=str(start.get("dateTime", "")),
            end_datetime=str(end.get("dateTime", "")),
            web_link=str(primitives.get("webLink", "")),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.id,
            "subject": self.subject,
            "start_datetime": self.start_datetime,
            "end_datetime": self.end_datetime,
            "web_link": self.web_link,
        }
