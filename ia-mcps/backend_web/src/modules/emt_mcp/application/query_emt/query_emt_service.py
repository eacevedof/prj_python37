from typing import Any, Self, final

from src.modules.shared.domain.enums.validation_message_enum import ValidationMessageEnum
from src.modules.shared.infrastructure.components.schema_validator.schema_validator import SchemaValidator

from src.modules.emt_mod.domain.enums.emt_result_key_enum import EmtResultKeyEnum
from src.modules.emt_mod.infrastructure.adapters.emt_query_adapter import EmtQueryAdapter

from src.modules.emt_mcp.domain.enums.tool_name_enum import ToolNameEnum
from src.modules.emt_mcp.domain.exceptions.emt_mcp_exception import EmtMcpException
from src.modules.emt_mcp.domain.ports.emt_query import EmtQuery
from src.modules.emt_mcp.infrastructure.repositories.tools_reader_in_memory_repository import (
    ToolsReaderInMemoryRepository,
)
from src.modules.emt_mcp.application.query_emt.query_emt_dto import QueryEmtDto
from src.modules.emt_mcp.application.query_emt.query_emt_result_dto import QueryEmtResultDto

# Un listado de 200 líneas no cabe en una respuesta útil para el agente: se
# recortan y se le dice cuántas quedan fuera, para que no crea que eso es todo.
_MAX_LISTED_LINES = 50


@final
class QueryEmtService:
    """Caso de uso de la fachada MCP: ejecutar una tool del servidor de EMT.

    NO tiene lógica de negocio: valida el payload contra el schema publicado,
    enruta al caso de uso de `emt_mod` a través del puerto y redacta el
    resultado como texto para el agente.
    """

    _schema_validator: SchemaValidator
    _tools_reader_in_memory_repository: ToolsReaderInMemoryRepository
    _emt_query: EmtQuery

    _query_emt_dto: QueryEmtDto

    def __init__(self) -> None:
        self._schema_validator = SchemaValidator.get_instance()
        self._tools_reader_in_memory_repository = ToolsReaderInMemoryRepository.get_instance()
        # Puerto EmtQuery (dominio): la fachada sabe QUÉ se le puede preguntar a
        # EMT; la API de mobilitylabs se queda en emt_mod.
        self._emt_query: EmtQuery = EmtQueryAdapter.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, query_emt_dto: QueryEmtDto) -> QueryEmtResultDto:
        """Caso de uso: QueryEmt.

        Returns:
            QueryEmtResultDto: texto de respuesta para el agente.

        Raises:
            EmtMcpException: si la tool no existe o el payload no cumple el
                inputSchema publicado.
            EmtException: la que propague el caso de uso de emt_mod.
        """
        self._query_emt_dto = query_emt_dto
        self._fail_if_wrong_input()

        if self._query_emt_dto.tool_name == ToolNameEnum.GET_STOP_ARRIVALS.value:
            text = await self.__get_stop_arrivals_text()
        elif self._query_emt_dto.tool_name == ToolNameEnum.GET_LINES_INFO.value:
            text = await self.__get_lines_info_text()
        elif self._query_emt_dto.tool_name == ToolNameEnum.GET_STOPS_AROUND.value:
            text = await self.__get_stops_around_text()
        elif self._query_emt_dto.tool_name == ToolNameEnum.GET_STOP_DETAIL.value:
            text = await self.__get_stop_detail_text()
        else:
            EmtMcpException.bad_request(f"unknown tool: {self._query_emt_dto.tool_name}")

        return QueryEmtResultDto.from_primitives({
            "tool_name": self._query_emt_dto.tool_name,
            "text": text,
        })

    def _fail_if_wrong_input(self) -> None:
        if not self._query_emt_dto.tool_name:
            EmtMcpException.bad_request(ValidationMessageEnum.TOOL_NAME_REQUIRED)
        self.__fail_if_payload_breaks_the_published_schema()

    def __fail_if_payload_breaks_the_published_schema(self) -> None:
        """El payload se contrasta contra el MISMO schema que se le publicó al
        modelo en `list_tools`: si no cumple, el error se lo devuelve la fachada
        y el caso de uso de negocio ni se entera."""
        input_schema = self._tools_reader_in_memory_repository.get_input_schema_by_tool_name(
            self._query_emt_dto.tool_name
        )
        if not input_schema:
            return
        first_error_message = self._schema_validator.get_first_error_message(
            self._query_emt_dto.payload_dict, input_schema
        )
        if first_error_message:
            EmtMcpException.bad_request(first_error_message)

    async def __get_stop_arrivals_text(self) -> str:
        result = await self._emt_query.get_stop_arrivals(self._query_emt_dto.payload_dict)
        stop_id = result[EmtResultKeyEnum.STOP_ID]
        stop_name = result[EmtResultKeyEnum.STOP_NAME]
        arrivals: list[dict[str, Any]] = result[EmtResultKeyEnum.ARRIVALS]

        if not arrivals:
            return f"no hay llegadas para la parada {stop_id} ({stop_name})"

        text_lines = [
            f"llegadas en la parada {stop_id} - {stop_name} ({result[EmtResultKeyEnum.TOTAL]} buses):\n"
        ]
        for arrival in arrivals:
            head_marker = " [en cabecera]" if arrival[EmtResultKeyEnum.IS_HEAD] else ""
            text_lines.append(
                f"- línea {arrival[EmtResultKeyEnum.LINE]} -> {arrival[EmtResultKeyEnum.DESTINATION]}{head_marker}\n"
                f"  llega en: {arrival[EmtResultKeyEnum.TIME_LEFT_MINUTES]} min"
                f" ({arrival[EmtResultKeyEnum.TIME_LEFT_SECONDS]}s)\n"
                f"  distancia: {arrival[EmtResultKeyEnum.DISTANCE_METERS]}m"
            )
        return "\n".join(text_lines)

    async def __get_lines_info_text(self) -> str:
        result = await self._emt_query.get_lines_info(self._query_emt_dto.payload_dict)
        lines: list[dict[str, Any]] = result[EmtResultKeyEnum.LINES]
        total = result[EmtResultKeyEnum.TOTAL]

        if not lines:
            return "no se han encontrado líneas"

        text_lines = [f"líneas de la EMT de Madrid ({total} líneas):\n"]
        for line in lines[:_MAX_LISTED_LINES]:
            text_lines.append(
                f"- {line[EmtResultKeyEnum.LABEL]}: {line[EmtResultKeyEnum.NAME_A]}"
                f" <-> {line[EmtResultKeyEnum.NAME_B]} (grupo: {line[EmtResultKeyEnum.GROUP]})"
            )
        if total > _MAX_LISTED_LINES:
            text_lines.append(f"\n... y {total - _MAX_LISTED_LINES} líneas más")
        return "\n".join(text_lines)

    async def __get_stops_around_text(self) -> str:
        result = await self._emt_query.get_stops_around(self._query_emt_dto.payload_dict)
        stops: list[dict[str, Any]] = result[EmtResultKeyEnum.STOPS]
        latitude = result[EmtResultKeyEnum.LATITUDE]
        longitude = result[EmtResultKeyEnum.LONGITUDE]
        radius = result[EmtResultKeyEnum.RADIUS]

        if not stops:
            return f"no hay paradas a menos de {radius}m de ({latitude}, {longitude})"

        text_lines = [
            f"paradas a menos de {radius}m de ({latitude}, {longitude})"
            f" ({result[EmtResultKeyEnum.TOTAL]} paradas):\n"
        ]
        for stop in stops:
            stop_lines = ", ".join(stop[EmtResultKeyEnum.LINES]) or "sin líneas"
            text_lines.append(
                f"- [{stop[EmtResultKeyEnum.STOP_ID]}] {stop[EmtResultKeyEnum.STOP_NAME]}\n"
                f"  dirección: {stop[EmtResultKeyEnum.ADDRESS]}\n"
                f"  líneas: {stop_lines}"
            )
        return "\n".join(text_lines)

    async def __get_stop_detail_text(self) -> str:
        result = await self._emt_query.get_stop_detail(self._query_emt_dto.payload_dict)
        stop_lines = ", ".join(result[EmtResultKeyEnum.LINES]) or "sin líneas"
        wifi_status = "sí" if result[EmtResultKeyEnum.WIFI] else "no"

        return (
            "detalle de la parada:\n"
            f"- id: {result[EmtResultKeyEnum.STOP_ID]}\n"
            f"- nombre: {result[EmtResultKeyEnum.STOP_NAME]}\n"
            f"- dirección: {result[EmtResultKeyEnum.ADDRESS]}\n"
            f"- código postal: {result[EmtResultKeyEnum.POSTAL_CODE]}\n"
            f"- coordenadas: ({result[EmtResultKeyEnum.LATITUDE]}, {result[EmtResultKeyEnum.LONGITUDE]})\n"
            f"- líneas: {stop_lines}\n"
            f"- wifi: {wifi_status}"
        )
