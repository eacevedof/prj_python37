from dataclasses import dataclass
from typing import Self, Any
from datetime import datetime


@dataclass(frozen=True, slots=True)
class AddHolidayDto:
    """Input DTO for adding a holiday to a calendar."""

    user_id: str
    calendar_name: str
    title: str
    day: int
    month: int
    year: int

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        year_raw = primitives.get("year")
        if year_raw is not None:
            year = int(year_raw)
        else:
            year = datetime.now().year

        return cls(
            user_id=str(primitives.get("user_id", "")).strip(),
            calendar_name=str(primitives.get("calendar_name", "")).strip(),
            title=str(primitives.get("title", "")).strip(),
            day=int(primitives.get("day", 1)),
            month=int(primitives.get("month", 1)),
            year=year,
        )

    def get_start_date(self) -> str:
        """Get the start date in ISO format for all-day event."""
        return f"{self.year:04d}-{self.month:02d}-{self.day:02d}T00:00:00"

    def get_end_date(self) -> str:
        """Get the end date in ISO format for all-day event (next day)."""
        from datetime import date, timedelta

        start = date(self.year, self.month, self.day)
        end = start + timedelta(days=1)
        return f"{end.year:04d}-{end.month:02d}-{end.day:02d}T00:00:00"
