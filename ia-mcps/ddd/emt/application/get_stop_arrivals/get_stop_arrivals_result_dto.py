from dataclasses import dataclass, field
from typing import Self, Any

from ddd.emt.application.get_stop_arrivals.arrival_item_dto import ArrivalItemDto


@dataclass(frozen=True, slots=True)
class GetStopArrivalsResultDto:
    """Output DTO containing bus arrivals for a stop."""

    stop_id: str = ""
    stop_name: str = ""
    arrivals: list[ArrivalItemDto] = field(default_factory=list)
    total: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        data = primitives.get("data", [])
        stop_data = data[0] if data else {}

        arrivals_raw = stop_data.get("Arrive", [])
        arrivals = [ArrivalItemDto.from_primitives(arr) for arr in arrivals_raw]

        stop_info = stop_data.get("StopInfo", [{}])
        stop_name = ""
        if stop_info and isinstance(stop_info, list) and stop_info[0]:
            stop_name = stop_info[0].get("stopName", "")

        return cls(
            stop_id=str(primitives.get("stop_id", "")),
            stop_name=stop_name,
            arrivals=arrivals,
            total=len(arrivals),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "stop_id": self.stop_id,
            "stop_name": self.stop_name,
            "arrivals": [arr.to_dict() for arr in self.arrivals],
            "total": self.total,
        }
