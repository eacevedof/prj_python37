from dataclasses import dataclass, field
from typing import Any, Self

from src.modules.emt_mod.domain.enums.emt_result_key_enum import EmtResultKeyEnum

_DEFAULT_RADIUS_METERS = 500
_COORDINATE_COUNT = 2


@dataclass(frozen=True, slots=True)
class GetStopsAroundResultDto:
    """Salida del caso de uso: las paradas alrededor de unas coordenadas."""

    stops: list[dict[str, Any]] = field(default_factory=list)
    total: int = 0
    latitude: float = 0.0
    longitude: float = 0.0
    radius: int = _DEFAULT_RADIUS_METERS

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        stops = [cls.__get_stop_primitives(raw_stop) for raw_stop in primitives.get("data", [])]

        return cls(
            stops=stops,
            total=len(stops),
            latitude=float(primitives.get("latitude", 0.0)),
            longitude=float(primitives.get("longitude", 0.0)),
            radius=int(primitives.get("radius", _DEFAULT_RADIUS_METERS)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            EmtResultKeyEnum.STOPS: self.stops,
            EmtResultKeyEnum.TOTAL: self.total,
            EmtResultKeyEnum.LATITUDE: self.latitude,
            EmtResultKeyEnum.LONGITUDE: self.longitude,
            EmtResultKeyEnum.RADIUS: self.radius,
        }

    @staticmethod
    def __get_stop_primitives(raw_stop: dict[str, Any]) -> dict[str, Any]:
        """Una parada de la API de EMT traducida al vocabulario del módulo.

        Estático porque lo llama `from_primitives`, que es de la clase y no de
        una instancia. Devuelve un dict y no otro DTO porque un DTO solo lleva
        primitivos.

        Dos rarezas de la API que se resuelven aquí: el id de la parada llega con
        tres nombres distintos según el endpoint (`stopId`, `stop`, `node`), y
        las coordenadas vienen en GeoJSON, o sea [longitud, latitud] — en ese
        orden, que es el contrario del que se lee.
        """
        coordinates = raw_stop.get("geometry", {}).get("coordinates", [0.0, 0.0])

        raw_lines = raw_stop.get("lines", [])
        lines = (
            [str(raw_line.get("line", "")) for raw_line in raw_lines if raw_line]
            if isinstance(raw_lines, list)
            else []
        )

        return {
            EmtResultKeyEnum.STOP_ID: str(
                raw_stop.get("stopId") or raw_stop.get("stop") or raw_stop.get("node") or ""
            ),
            EmtResultKeyEnum.STOP_NAME: str(raw_stop.get("stopName", "")),
            EmtResultKeyEnum.LATITUDE: (
                float(coordinates[1]) if len(coordinates) >= _COORDINATE_COUNT else 0.0
            ),
            EmtResultKeyEnum.LONGITUDE: float(coordinates[0]) if coordinates else 0.0,
            EmtResultKeyEnum.ADDRESS: str(raw_stop.get("address", "")),
            EmtResultKeyEnum.LINES: lines,
        }
