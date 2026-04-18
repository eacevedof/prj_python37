from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class StopItemDto:
    """DTO representing a bus stop."""

    stop_id: str
    stop_name: str
    latitude: float
    longitude: float
    address: str
    lines: list[str] = field(default_factory=list)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        geometry = primitives.get("geometry", {})
        coordinates = geometry.get("coordinates", [0.0, 0.0])

        lines_raw = primitives.get("lines", [])
        lines: list[str] = []
        if isinstance(lines_raw, list):
            lines = [str(line.get("line", "")) for line in lines_raw if line]

        return cls(
            stop_id=str(primitives.get("stop", "")),
            stop_name=str(primitives.get("stopName", "")),
            latitude=float(coordinates[1]) if len(coordinates) > 1 else 0.0,
            longitude=float(coordinates[0]) if coordinates else 0.0,
            address=str(primitives.get("address", "")),
            lines=lines,
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "stop_id": self.stop_id,
            "stop_name": self.stop_name,
            "latitude": self.latitude,
            "longitude": self.longitude,
            "address": self.address,
            "lines": self.lines,
        }
