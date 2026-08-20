from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class ArrivalItemDto:
    """DTO representing a single bus arrival."""

    line: str
    destination: str
    time_left_seconds: int
    time_left_minutes: int
    distance_meters: int
    is_head: bool
    deviation: int

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        time_left_seconds = int(primitives.get("estimateArrive", 0))
        time_left_minutes = time_left_seconds // 60 if time_left_seconds > 0 else 0

        return cls(
            line=str(primitives.get("line", "")),
            destination=str(primitives.get("destination", "")),
            time_left_seconds=time_left_seconds,
            time_left_minutes=time_left_minutes,
            distance_meters=int(primitives.get("DistanceBus", 0)),
            is_head=bool(primitives.get("isHead", False)),
            deviation=int(primitives.get("deviation", 0)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "line": self.line,
            "destination": self.destination,
            "time_left_seconds": self.time_left_seconds,
            "time_left_minutes": self.time_left_minutes,
            "distance_meters": self.distance_meters,
            "is_head": self.is_head,
            "deviation": self.deviation,
        }
