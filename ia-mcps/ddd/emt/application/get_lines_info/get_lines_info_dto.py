from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class GetLinesInfoDto:
    """Input DTO for getting bus lines information."""

    date: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        date = primitives.get("date")
        if date is not None:
            date = str(date).strip() or None

        return cls(date=date)
