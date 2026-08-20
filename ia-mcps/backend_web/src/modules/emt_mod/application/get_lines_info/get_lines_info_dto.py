from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class GetLinesInfoDto:
    """Input DTO for getting a bus line information."""

    line_id: str
    date: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        line_id = str(primitives.get("line_id", "")).strip()

        date = primitives.get("date")
        if date is not None:
            date = str(date).strip() or None

        return cls(line_id=line_id, date=date)
