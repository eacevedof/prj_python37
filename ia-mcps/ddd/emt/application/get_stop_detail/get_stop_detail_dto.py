from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class GetStopDetailDto:
    """Input DTO for getting bus stop details."""

    stop_id: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        stop_id = str(primitives.get("stop_id", "")).strip()
        return cls(stop_id=stop_id)
