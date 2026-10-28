from typing import Any, Self, final

from src.modules.shared.domain.enums.validation_message_enum import ValidationMessageEnum
from src.modules.shared.infrastructure.components.schema_validator.schema_validator import SchemaValidator

# Los listados (llegadas, líneas, paradas, favoritos) viajan como dicts dentro
# de su ResultDto, por la regla de DTOs planos: sus claves se leen del enum del
# módulo que las produce.
from src.modules.emt_mod.domain.enums.emt_result_key_enum import EmtResultKeyEnum
from src.modules.emt_mod.domain.enums.favorite_stop_key_enum import FavoriteStopKeyEnum
from src.modules.emt_mod.application.add_favorite_stop.add_favorite_stop_dto import (
    AddFavoriteStopDto,
)
from src.modules.emt_mod.application.add_favorite_stop.add_favorite_stop_service import (
    AddFavoriteStopService,
)
from src.modules.emt_mod.application.delete_favorite_stop.delete_favorite_stop_dto import (
    DeleteFavoriteStopDto,
)
from src.modules.emt_mod.application.delete_favorite_stop.delete_favorite_stop_service import (
    DeleteFavoriteStopService,
)
from src.modules.emt_mod.application.get_favorite_stops.get_favorite_stops_dto import (
    GetFavoriteStopsDto,
)
from src.modules.emt_mod.application.get_favorite_stops.get_favorite_stops_service import (
    GetFavoriteStopsService,
)
from src.modules.emt_mod.application.get_lines_info.get_lines_info_dto import GetLinesInfoDto
from src.modules.emt_mod.application.get_lines_info.get_lines_info_service import GetLinesInfoService
from src.modules.emt_mod.application.get_stop_arrivals.get_stop_arrivals_dto import (
    GetStopArrivalsDto,
)
from src.modules.emt_mod.application.get_stop_arrivals.get_stop_arrivals_service import (
    GetStopArrivalsService,
)
from src.modules.emt_mod.application.get_stop_detail.get_stop_detail_dto import GetStopDetailDto
from src.modules.emt_mod.application.get_stop_detail.get_stop_detail_service import (
    GetStopDetailService,
)
from src.modules.emt_mod.application.get_stops_around.get_stops_around_dto import GetStopsAroundDto
from src.modules.emt_mod.application.get_stops_around.get_stops_around_service import (
    GetStopsAroundService,
)
from src.modules.emt_mod.application.update_favorite_stop.update_favorite_stop_dto import (
    UpdateFavoriteStopDto,
)
from src.modules.emt_mod.application.update_favorite_stop.update_favorite_stop_service import (
    UpdateFavoriteStopService,
)

from src.modules.users_mod.application.get_users.get_users_dto import GetUsersDto
from src.modules.users_mod.application.get_users.get_users_service import GetUsersService
from src.modules.users_mod.domain.enums.user_key_enum import UserKeyEnum
from src.modules.users_mod.domain.enums.user_role_enum import UserRoleEnum

from src.modules.emt_mcp.domain.enums.tool_name_enum import ToolNameEnum
from src.modules.emt_mcp.domain.exceptions.emt_mcp_exception import EmtMcpException
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
    llama al caso de uso de `emt_mod` y redacta el resultado como texto para el
    agente. Importa los services y sus DTOs directamente: la dependencia va de
    la boca al core, que es la dirección natural.

    Con `users_mod` (otro bounded context) pasa lo mismo: se importa su caso de
    uso, no un puerto.
    """

    _schema_validator: SchemaValidator
    _tools_reader_in_memory_repository: ToolsReaderInMemoryRepository
    _get_stop_arrivals_service: GetStopArrivalsService
    _get_lines_info_service: GetLinesInfoService
    _get_stops_around_service: GetStopsAroundService
    _get_stop_detail_service: GetStopDetailService
    _add_favorite_stop_service: AddFavoriteStopService
    _get_favorite_stops_service: GetFavoriteStopsService
    _update_favorite_stop_service: UpdateFavoriteStopService
    _delete_favorite_stop_service: DeleteFavoriteStopService
    _get_users_service: GetUsersService

    _query_emt_dto: QueryEmtDto

    def __init__(self) -> None:
        self._schema_validator = SchemaValidator.get_instance()
        self._tools_reader_in_memory_repository = ToolsReaderInMemoryRepository.get_instance()
        self._get_stop_arrivals_service = GetStopArrivalsService.get_instance()
        self._get_lines_info_service = GetLinesInfoService.get_instance()
        self._get_stops_around_service = GetStopsAroundService.get_instance()
        self._get_stop_detail_service = GetStopDetailService.get_instance()
        self._add_favorite_stop_service = AddFavoriteStopService.get_instance()
        self._get_favorite_stops_service = GetFavoriteStopsService.get_instance()
        self._update_favorite_stop_service = UpdateFavoriteStopService.get_instance()
        self._delete_favorite_stop_service = DeleteFavoriteStopService.get_instance()
        # La fachada no comprueba roles: eso lo hace `GetUsersService`, así que si
        # quien pregunta no es admin lo que llega aquí es una excepción.
        self._get_users_service = GetUsersService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self,
        query_emt_dto: QueryEmtDto
    ) -> QueryEmtResultDto:
        """Caso de uso: QueryEmt.

        Returns:
            QueryEmtResultDto: texto de respuesta para el agente.

        Raises:
            EmtMcpException: si la tool no existe o el payload no cumple el
                inputSchema publicado.
            EmtException: la que propague el caso de uso de emt_mod.
            UsersException: la que propague el guardarraíl de users_mod cuando
                quien llama no puede hacer lo que pide.
        """
        self._query_emt_dto = query_emt_dto
        self._fail_if_wrong_input()

        text = ""
        if self._query_emt_dto.tool_name == ToolNameEnum.GET_STOP_ARRIVALS.value:
            text = await self.__get_stop_arrivals_text()
        elif self._query_emt_dto.tool_name == ToolNameEnum.GET_LINES_INFO.value:
            text = await self.__get_lines_info_text()
        elif self._query_emt_dto.tool_name == ToolNameEnum.GET_STOPS_AROUND.value:
            text = await self.__get_stops_around_text()
        elif self._query_emt_dto.tool_name == ToolNameEnum.GET_STOP_DETAIL.value:
            text = await self.__get_stop_detail_text()
        elif self._query_emt_dto.tool_name == ToolNameEnum.ADD_FAVORITE_STOP.value:
            text = await self.__get_added_favorite_stop_text()
        elif self._query_emt_dto.tool_name == ToolNameEnum.GET_FAVORITE_STOPS.value:
            text = await self.__get_favorite_stops_text()
        elif self._query_emt_dto.tool_name == ToolNameEnum.UPDATE_FAVORITE_STOP.value:
            text = await self.__get_updated_favorite_stop_text()
        elif self._query_emt_dto.tool_name == ToolNameEnum.DELETE_FAVORITE_STOP.value:
            text = await self.__get_deleted_favorite_stop_text()
        elif self._query_emt_dto.tool_name == ToolNameEnum.GET_USERS.value:
            text = await self.__get_users_text()
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
        get_stop_arrivals_result_dto = await self._get_stop_arrivals_service(
            GetStopArrivalsDto.from_primitives(self._query_emt_dto.payload_dict)
        )
        arrivals: list[dict[str, Any]] = get_stop_arrivals_result_dto.arrivals
        stop_id = get_stop_arrivals_result_dto.stop_id
        stop_name = get_stop_arrivals_result_dto.stop_name

        if not arrivals:
            return f"no hay llegadas para la parada {stop_id} ({stop_name})"

        text_lines = [
            f"llegadas en la parada {stop_id} - {stop_name}"
            f" ({get_stop_arrivals_result_dto.total} buses):\n"
        ]
        for arrival in arrivals:
            head_marker = " [en cabecera]" if arrival[EmtResultKeyEnum.IS_HEAD] else ""
            text_lines.append(
                f"- línea {arrival[EmtResultKeyEnum.LINE]}"
                f" -> {arrival[EmtResultKeyEnum.DESTINATION]}{head_marker}\n"
                f"  llega en: {arrival[EmtResultKeyEnum.TIME_LEFT_MINUTES]} min"
                f" ({arrival[EmtResultKeyEnum.TIME_LEFT_SECONDS]}s)\n"
                f"  distancia: {arrival[EmtResultKeyEnum.DISTANCE_METERS]}m"
            )
        return "\n".join(text_lines)

    async def __get_lines_info_text(self) -> str:
        get_lines_info_result_dto = await self._get_lines_info_service(
            GetLinesInfoDto.from_primitives(self._query_emt_dto.payload_dict)
        )
        lines: list[dict[str, Any]] = get_lines_info_result_dto.lines
        total = get_lines_info_result_dto.total

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
        get_stops_around_result_dto = await self._get_stops_around_service(
            GetStopsAroundDto.from_primitives(self._query_emt_dto.payload_dict)
        )
        stops: list[dict[str, Any]] = get_stops_around_result_dto.stops
        latitude = get_stops_around_result_dto.latitude
        longitude = get_stops_around_result_dto.longitude
        radius = get_stops_around_result_dto.radius

        if not stops:
            return f"no hay paradas a menos de {radius}m de ({latitude}, {longitude})"

        text_lines = [
            f"paradas a menos de {radius}m de ({latitude}, {longitude})"
            f" ({get_stops_around_result_dto.total} paradas):\n"
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
        get_stop_detail_result_dto = await self._get_stop_detail_service(
            GetStopDetailDto.from_primitives(self._query_emt_dto.payload_dict)
        )
        stop_lines = ", ".join(get_stop_detail_result_dto.lines) or "sin líneas"
        wifi_status = "sí" if get_stop_detail_result_dto.wifi else "no"

        return (
            f"detalle de la parada:\n"
            f"- id: {get_stop_detail_result_dto.stop_id}\n"
            f"- nombre: {get_stop_detail_result_dto.stop_name}\n"
            f"- dirección: {get_stop_detail_result_dto.address}\n"
            f"- código postal: {get_stop_detail_result_dto.postal_code}\n"
            f"- coordenadas: ({get_stop_detail_result_dto.latitude},"
            f" {get_stop_detail_result_dto.longitude})\n"
            f"- líneas: {stop_lines}\n"
            f"- wifi: {wifi_status}"
        )

    def __get_owner_text_suffix(self, owner_user_tg_id: str, is_other_user: bool) -> str:
        """Coletilla que deja claro de QUIÉN son las paradas.

        Solo aparece cuando un admin está operando sobre otro: en el caso normal
        no se nombra a nadie, para que el texto no dé pistas de qué usuarios hay.
        """
        if not is_other_user:
            return ""
        return f" de {owner_user_tg_id}"

    async def __get_added_favorite_stop_text(self) -> str:
        add_favorite_stop_result_dto = await self._add_favorite_stop_service(
            AddFavoriteStopDto.from_primitives(self._query_emt_dto.payload_dict)
        )
        stop_description = add_favorite_stop_result_dto.stop_description
        description_text = f" como '{stop_description}'" if stop_description else ""
        owner_text_suffix = self.__get_owner_text_suffix(
            add_favorite_stop_result_dto.owner_user_tg_id,
            add_favorite_stop_result_dto.is_other_user,
        )
        return (
            f"parada {add_favorite_stop_result_dto.stop_nr} guardada en favoritos"
            f"{owner_text_suffix}{description_text}"
        )

    async def __get_favorite_stops_text(self) -> str:
        get_favorite_stops_result_dto = await self._get_favorite_stops_service(
            GetFavoriteStopsDto.from_primitives(self._query_emt_dto.payload_dict)
        )
        favorite_stops: list[dict[str, Any]] = get_favorite_stops_result_dto.favorite_stops
        owner_text_suffix = self.__get_owner_text_suffix(
            get_favorite_stops_result_dto.owner_user_tg_id,
            get_favorite_stops_result_dto.is_other_user,
        )

        if not favorite_stops:
            return f"no hay paradas favoritas guardadas{owner_text_suffix}"

        text_lines = [
            f"paradas favoritas{owner_text_suffix}"
            f" ({get_favorite_stops_result_dto.total}):\n"
        ]
        for favorite_stop in favorite_stops:
            stop_description = (
                favorite_stop[FavoriteStopKeyEnum.STOP_DESCRIPTION] or "sin descripción"
            )
            text_lines.append(f"- [{favorite_stop[FavoriteStopKeyEnum.STOP_NR]}] {stop_description}")
        return "\n".join(text_lines)

    async def __get_updated_favorite_stop_text(self) -> str:
        update_favorite_stop_result_dto = await self._update_favorite_stop_service(
            UpdateFavoriteStopDto.from_primitives(self._query_emt_dto.payload_dict)
        )
        owner_text_suffix = self.__get_owner_text_suffix(
            update_favorite_stop_result_dto.owner_user_tg_id,
            update_favorite_stop_result_dto.is_other_user,
        )
        return (
            f"parada {update_favorite_stop_result_dto.stop_nr} actualizada{owner_text_suffix}:"
            f" '{update_favorite_stop_result_dto.stop_description}'"
        )

    async def __get_deleted_favorite_stop_text(self) -> str:
        delete_favorite_stop_result_dto = await self._delete_favorite_stop_service(
            DeleteFavoriteStopDto.from_primitives(self._query_emt_dto.payload_dict)
        )
        owner_text_suffix = self.__get_owner_text_suffix(
            delete_favorite_stop_result_dto.owner_user_tg_id,
            delete_favorite_stop_result_dto.is_other_user,
        )
        return (
            f"parada {delete_favorite_stop_result_dto.stop_nr} quitada de favoritos"
            f"{owner_text_suffix}"
        )

    async def __get_users_text(self) -> str:
        get_users_result_dto = await self._get_users_service(
            GetUsersDto.from_primitives(self._query_emt_dto.payload_dict)
        )
        users: list[dict[str, Any]] = get_users_result_dto.users

        if not users:
            return "no hay usuarios dados de alta"

        text_lines = [f"usuarios dados de alta ({get_users_result_dto.total}):\n"]
        for user in users:
            role_text = (
                "admin"
                if int(user[UserKeyEnum.USER_ROLE_ID]) == UserRoleEnum.ADMIN
                else "usuario"
            )
            status_text = "activo" if int(user[UserKeyEnum.IS_ENABLED]) else "deshabilitado"
            text_lines.append(
                f"- {user[UserKeyEnum.USER_NAME]} [telegram: {user[UserKeyEnum.USER_TG_ID]}]"
                f" - {role_text}, {status_text}"
            )
        return "\n".join(text_lines)
