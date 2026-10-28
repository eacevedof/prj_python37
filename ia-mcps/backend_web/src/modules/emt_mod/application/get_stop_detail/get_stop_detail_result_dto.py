from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class GetStopDetailResultDto:
    """Output DTO containing bus stop details."""

    stop_id: str = ""
    stop_name: str = ""
    latitude: float = 0.0
    longitude: float = 0.0
    address: str = ""
    postal_code: str = ""
    lines: list[str] = field(default_factory=list)
    wifi: bool = False

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        data = primitives.get("data", [])
        stop_data = data[0] if data else {}

        geometry = stop_data.get("geometry", {})
        coordinates = geometry.get("coordinates", [0.0, 0.0])

        lines_raw = stop_data.get("lines", [])
        lines: list[str] = []
        if isinstance(lines_raw, list):
            lines = [str(line.get("line", "")) for line in lines_raw if line]

        return cls(
            stop_id=str(stop_data.get("stop", primitives.get("stop_id", ""))),
            stop_name=str(stop_data.get("stopName", "")),
            latitude=float(coordinates[1]) if len(coordinates) > 1 else 0.0,
            longitude=float(coordinates[0]) if coordinates else 0.0,
            address=str(stop_data.get("address", "")),
            postal_code=str(stop_data.get("postalCode", "")),
            lines=lines,
            wifi=bool(stop_data.get("wifi", False)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "stop_id": self.stop_id,
            "stop_name": self.stop_name,
            "latitude": self.latitude,
            "longitude": self.longitude,
            "address": self.address,
            "postal_code": self.postal_code,
            "lines": self.lines,
            "wifi": self.wifi,
        }
