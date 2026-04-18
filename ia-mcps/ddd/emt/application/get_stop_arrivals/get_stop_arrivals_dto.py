from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class GetStopArrivalsDto:
    """Input DTO for getting bus arrivals at a stop."""

    stop_id: str
    line_ids: list[str] | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        stop_id = str(primitives.get("stop_id", "")).strip()

        line_ids_raw = primitives.get("line_ids")
        line_ids: list[str] | None = None
        if line_ids_raw:
            if isinstance(line_ids_raw, str):
                line_ids = [lid.strip() for lid in line_ids_raw.split(",") if lid.strip()]
            elif isinstance(line_ids_raw, list):
                line_ids = [str(lid).strip() for lid in line_ids_raw if lid]

        return cls(
            stop_id=stop_id,
            line_ids=line_ids,
        )
