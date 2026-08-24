from dataclasses import dataclass, field
from typing import Any, Self

from src.modules.emt_mod.domain.enums.emt_result_key_enum import EmtResultKeyEnum

_SECONDS_PER_MINUTE = 60


@dataclass(frozen=True, slots=True)
class GetStopArrivalsResultDto:
    """Salida del caso de uso: las llegadas en tiempo real a una parada."""

    stop_id: str = ""
    stop_name: str = ""
    arrivals: list[dict[str, Any]] = field(default_factory=list)
    total: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        data = primitives.get("data", [])
        stop_data = data[0] if data else {}

        arrivals = [
            cls.__get_arrival_primitives(raw_arrival)
            for raw_arrival in stop_data.get("Arrive", [])
        ]

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
            EmtResultKeyEnum.STOP_ID: self.stop_id,
            EmtResultKeyEnum.STOP_NAME: self.stop_name,
            EmtResultKeyEnum.ARRIVALS: self.arrivals,
            EmtResultKeyEnum.TOTAL: self.total,
        }

    @staticmethod
    def __get_arrival_primitives(raw_arrival: dict[str, Any]) -> dict[str, Any]:
        """Una llegada de la API de EMT traducida al vocabulario del módulo.

        Estático porque lo llama `from_primitives`, que es de la clase y no de
        una instancia: cuando esto corre todavía no hay DTO que construir.
        Devuelve un dict y no otro DTO porque un DTO solo lleva primitivos.

        Aquí es donde `estimateArrive` (segundos) se convierte en los minutos que
        el agente lee.
        """
        time_left_seconds = int(raw_arrival.get("estimateArrive", 0))

        return {
            EmtResultKeyEnum.LINE: str(raw_arrival.get("line", "")),
            EmtResultKeyEnum.DESTINATION: str(raw_arrival.get("destination", "")),
            EmtResultKeyEnum.TIME_LEFT_SECONDS: time_left_seconds,
            EmtResultKeyEnum.TIME_LEFT_MINUTES: (
                time_left_seconds // _SECONDS_PER_MINUTE if time_left_seconds > 0 else 0
            ),
            EmtResultKeyEnum.DISTANCE_METERS: int(raw_arrival.get("DistanceBus", 0)),
            EmtResultKeyEnum.IS_HEAD: bool(raw_arrival.get("isHead", False)),
            EmtResultKeyEnum.DEVIATION: int(raw_arrival.get("deviation", 0)),
        }
