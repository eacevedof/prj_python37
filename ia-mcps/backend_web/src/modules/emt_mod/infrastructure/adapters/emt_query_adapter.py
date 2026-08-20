from typing import Any, Self, final

from src.modules.emt_mod.application.get_lines_info.get_lines_info_dto import GetLinesInfoDto
from src.modules.emt_mod.application.get_lines_info.get_lines_info_service import GetLinesInfoService
from src.modules.emt_mod.application.get_stop_arrivals.get_stop_arrivals_dto import GetStopArrivalsDto
from src.modules.emt_mod.application.get_stop_arrivals.get_stop_arrivals_service import (
    GetStopArrivalsService,
)
from src.modules.emt_mod.application.get_stop_detail.get_stop_detail_dto import GetStopDetailDto
from src.modules.emt_mod.application.get_stop_detail.get_stop_detail_service import GetStopDetailService
from src.modules.emt_mod.application.get_stops_around.get_stops_around_dto import GetStopsAroundDto
from src.modules.emt_mod.application.get_stops_around.get_stops_around_service import (
    GetStopsAroundService,
)


@final
class EmtQueryAdapter:
    """Implementación del puerto `EmtQuery` (emt_mcp/domain).

    Única puerta de este módulo hacia la fachada MCP: recibe primitivos, arma el
    DTO del caso de uso, lo invoca y devuelve primitivos con el `to_dict()` del
    ResultDto — el MISMO contrato que serviría un camino REST.
    """

    _get_stop_arrivals_service: GetStopArrivalsService
    _get_lines_info_service: GetLinesInfoService
    _get_stops_around_service: GetStopsAroundService
    _get_stop_detail_service: GetStopDetailService

    def __init__(self) -> None:
        self._get_stop_arrivals_service = GetStopArrivalsService.get_instance()
        self._get_lines_info_service = GetLinesInfoService.get_instance()
        self._get_stops_around_service = GetStopsAroundService.get_instance()
        self._get_stop_detail_service = GetStopDetailService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def get_stop_arrivals(self, primitives: dict[str, Any]) -> dict[str, Any]:
        result_dto = await self._get_stop_arrivals_service(
            GetStopArrivalsDto.from_primitives(primitives)
        )
        return result_dto.to_dict()

    async def get_lines_info(self, primitives: dict[str, Any]) -> dict[str, Any]:
        result_dto = await self._get_lines_info_service(GetLinesInfoDto.from_primitives(primitives))
        return result_dto.to_dict()

    async def get_stops_around(self, primitives: dict[str, Any]) -> dict[str, Any]:
        result_dto = await self._get_stops_around_service(
            GetStopsAroundDto.from_primitives(primitives)
        )
        return result_dto.to_dict()

    async def get_stop_detail(self, primitives: dict[str, Any]) -> dict[str, Any]:
        result_dto = await self._get_stop_detail_service(
            GetStopDetailDto.from_primitives(primitives)
        )
        return result_dto.to_dict()
