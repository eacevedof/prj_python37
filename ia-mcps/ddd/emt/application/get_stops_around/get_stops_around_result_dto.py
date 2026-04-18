from dataclasses import dataclass, field
from typing import Self, Any

from ddd.emt.application.get_stops_around.stop_item_dto import StopItemDto


@dataclass(frozen=True, slots=True)
class GetStopsAroundResultDto:
    """Output DTO containing bus stops around a location."""

    stops: list[StopItemDto] = field(default_factory=list)
    total: int = 0
    latitude: float = 0.0
    longitude: float = 0.0
    radius: int = 500

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        data = primitives.get("data", [])
        stops = [StopItemDto.from_primitives(stop) for stop in data]

        return cls(
            stops=stops,
            total=len(stops),
            latitude=float(primitives.get("latitude", 0.0)),
            longitude=float(primitives.get("longitude", 0.0)),
            radius=int(primitives.get("radius", 500)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "stops": [stop.to_dict() for stop in self.stops],
            "total": self.total,
            "latitude": self.latitude,
            "longitude": self.longitude,
            "radius": self.radius,
        }
