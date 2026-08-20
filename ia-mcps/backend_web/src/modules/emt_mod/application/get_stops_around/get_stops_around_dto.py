from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class GetStopsAroundDto:
    """Input DTO for getting bus stops around a location."""

    latitude: float
    longitude: float
    radius: int = 500

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        latitude = float(primitives.get("latitude", 0.0))
        longitude = float(primitives.get("longitude", 0.0))
        radius = int(primitives.get("radius", 500))

        return cls(
            latitude=latitude,
            longitude=longitude,
            radius=radius,
        )
