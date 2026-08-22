import json
from typing import Any, Awaitable, Callable, Self, final

from src.modules.shared.domain.enums.validation_message_enum import ValidationMessageEnum
from src.modules.shared.infrastructure.components.schema_validator.schema_validator import SchemaValidator

from src.modules.memory_mod.domain.enums import MemoryTypeEnum
from src.modules.memory_mod.application.check_freshness.check_freshness_dto import CheckFreshnessDto
from src.modules.memory_mod.application.check_freshness.check_freshness_service import (
    CheckFreshnessService,
)
from src.modules.memory_mod.application.delete_memory.delete_memory_dto import DeleteMemoryDto
from src.modules.memory_mod.application.delete_memory.delete_memory_service import (
    DeleteMemoryService,
)
from src.modules.memory_mod.application.list_memories.list_memories_dto import ListMemoriesDto
from src.modules.memory_mod.application.list_memories.list_memories_service import (
    ListMemoriesService,
)
from src.modules.memory_mod.application.search_memory.search_memory_dto import SearchMemoryDto
from src.modules.memory_mod.application.search_memory.search_memory_service import (
    SearchMemoryService,
)
from src.modules.memory_mod.application.store_file.store_file_dto import StoreFileDto
from src.modules.memory_mod.application.store_file.store_file_service import StoreFileService
from src.modules.memory_mod.application.store_memory.store_memory_dto import StoreMemoryDto
from src.modules.memory_mod.application.store_memory.store_memory_service import StoreMemoryService
from src.modules.memory_mod.application.update_memory.update_memory_dto import UpdateMemoryDto
from src.modules.memory_mod.application.update_memory.update_memory_service import (
    UpdateMemoryService,
)

from src.modules.memory_mcp.domain.enums.tool_name_enum import ToolNameEnum
from src.modules.memory_mcp.domain.exceptions.memory_mcp_exception import MemoryMcpException
from src.modules.memory_mcp.infrastructure.repositories.tools_reader_in_memory_repository import (
    ToolsReaderInMemoryRepository,
)
from src.modules.memory_mcp.application.manage_memory.manage_memory_dto import ManageMemoryDto
from src.modules.memory_mcp.application.manage_memory.manage_memory_result_dto import (
    ManageMemoryResultDto,
)

_JSON_INDENT = 2
_DEFAULT_SEARCH_LIMIT = 5
_DEFAULT_FILE_MEMORY_TYPE = "documentation"


@final
class ManageMemoryService:
    """Caso de uso de la fachada MCP: ejecutar una tool del servidor de memory.

    NO tiene lógica de negocio: valida el payload contra el schema publicado,
    llama al caso de uso de `memory_mod` y devuelve el resultado. Importa los
    services y sus DTOs directamente: la dependencia va de la boca al core, que
    es la dirección natural.

    Aquí es donde el `type` que manda el agente (una cadena) se convierte en
    `MemoryTypeEnum`: el caso de uso no debe recibir cadenas sueltas.

    A diferencia del resto de fachadas, aquí la respuesta es **JSON**, no prosa:
    son 7 tools que devuelven listados, ids y marcas de frescura que el agente
    encadena entre llamadas (buscar -> actualizar por chunk_id). Redactarlo como
    texto obligaría al modelo a volver a parsearlo. Es el contrato que ya tenía
    el servidor stdio.
    """

    _schema_validator: SchemaValidator
    _tools_reader_in_memory_repository: ToolsReaderInMemoryRepository
    _store_memory_service: StoreMemoryService
    _search_memory_service: SearchMemoryService
    _check_freshness_service: CheckFreshnessService
    _list_memories_service: ListMemoriesService
    _delete_memory_service: DeleteMemoryService
    _update_memory_service: UpdateMemoryService
    _store_file_service: StoreFileService

    _manage_memory_dto: ManageMemoryDto

    def __init__(self) -> None:
        self._schema_validator = SchemaValidator.get_instance()
        self._tools_reader_in_memory_repository = ToolsReaderInMemoryRepository.get_instance()
        self._store_memory_service = StoreMemoryService.get_instance()
        self._search_memory_service = SearchMemoryService.get_instance()
        self._check_freshness_service = CheckFreshnessService.get_instance()
        self._list_memories_service = ListMemoriesService.get_instance()
        self._delete_memory_service = DeleteMemoryService.get_instance()
        self._update_memory_service = UpdateMemoryService.get_instance()
        self._store_file_service = StoreFileService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, manage_memory_dto: ManageMemoryDto) -> ManageMemoryResultDto:
        """Caso de uso: ManageMemory.

        Returns:
            ManageMemoryResultDto: JSON de respuesta para el agente.

        Raises:
            MemoryMcpException: si la tool no existe o el payload no cumple el
                inputSchema publicado.
            MemoryException: la que propague el caso de uso de memory_mod.
        """
        self._manage_memory_dto = manage_memory_dto
        self._fail_if_wrong_input()

        result = await self.__get_tool_result()
        return ManageMemoryResultDto.from_primitives({
            "tool_name": self._manage_memory_dto.tool_name,
            "text": json.dumps(result, indent=_JSON_INDENT, ensure_ascii=False, default=str),
        })

    def _fail_if_wrong_input(self) -> None:
        if not self._manage_memory_dto.tool_name:
            MemoryMcpException.bad_request(ValidationMessageEnum.TOOL_NAME_REQUIRED)
        self.__fail_if_payload_breaks_the_published_schema()

    def __fail_if_payload_breaks_the_published_schema(self) -> None:
        input_schema = self._tools_reader_in_memory_repository.get_input_schema_by_tool_name(
            self._manage_memory_dto.tool_name
        )
        if not input_schema:
            return
        first_error_message = self._schema_validator.get_first_error_message(
            self._manage_memory_dto.payload_dict, input_schema
        )
        if first_error_message:
            MemoryMcpException.bad_request(first_error_message)

    async def __get_tool_result(self) -> dict[str, Any]:
        """Enruta por tabla y no por cadena de `elif`: son 7 tools que se
        corresponden 1:1 con los casos de uso de `memory_mod`."""
        use_case_call_by_tool_name: dict[
            str, Callable[[dict[str, Any]], Awaitable[dict[str, Any]]]
        ] = {
            ToolNameEnum.STORE.value: self.__get_stored_memory,
            ToolNameEnum.SEARCH.value: self.__get_searched_memories,
            ToolNameEnum.CHECK_FRESHNESS.value: self.__get_checked_freshness,
            ToolNameEnum.LIST.value: self.__get_listed_memories,
            ToolNameEnum.DELETE.value: self.__get_deleted_memory,
            ToolNameEnum.UPDATE.value: self.__get_updated_memory,
            ToolNameEnum.STORE_FILE.value: self.__get_stored_file,
        }
        use_case_call = use_case_call_by_tool_name.get(self._manage_memory_dto.tool_name)
        if use_case_call is None:
            MemoryMcpException.bad_request(f"unknown tool: {self._manage_memory_dto.tool_name}")
        return await use_case_call(self._manage_memory_dto.payload_dict)

    async def __get_stored_memory(self, primitives: dict[str, Any]) -> dict[str, Any]:
        store_memory_result_dto = await self._store_memory_service(
            StoreMemoryDto(
                project=primitives["project"],
                memory_type=MemoryTypeEnum(primitives["type"]),
                content=primitives["content"],
                paths=primitives.get("paths"),
                metadata=primitives.get("metadata"),
            )
        )
        return store_memory_result_dto.to_primitives()

    async def __get_searched_memories(self, primitives: dict[str, Any]) -> dict[str, Any]:
        search_memory_result_dto = await self._search_memory_service(
            SearchMemoryDto(
                project=primitives["project"],
                query=primitives["query"],
                limit=primitives.get("limit", _DEFAULT_SEARCH_LIMIT),
                memory_type=self.__get_memory_type_or_none(primitives),
            )
        )
        return search_memory_result_dto.to_primitives()

    async def __get_checked_freshness(self, primitives: dict[str, Any]) -> dict[str, Any]:
        check_freshness_result_dto = await self._check_freshness_service(
            CheckFreshnessDto(project=primitives["project"])
        )
        return check_freshness_result_dto.to_primitives()

    async def __get_listed_memories(self, primitives: dict[str, Any]) -> dict[str, Any]:
        list_memories_result_dto = await self._list_memories_service(
            ListMemoriesDto(
                project=primitives["project"],
                memory_type=self.__get_memory_type_or_none(primitives),
                stale_only=primitives.get("stale_only", False),
            )
        )
        return list_memories_result_dto.to_primitives()

    async def __get_deleted_memory(self, primitives: dict[str, Any]) -> dict[str, Any]:
        delete_memory_result_dto = await self._delete_memory_service(
            DeleteMemoryDto(chunk_id=primitives["chunk_id"], project=primitives["project"])
        )
        return delete_memory_result_dto.to_primitives()

    async def __get_updated_memory(self, primitives: dict[str, Any]) -> dict[str, Any]:
        update_memory_result_dto = await self._update_memory_service(
            UpdateMemoryDto(
                chunk_id=primitives["chunk_id"],
                project=primitives["project"],
                content=primitives.get("content"),
                paths=primitives.get("paths"),
                metadata=primitives.get("metadata"),
            )
        )
        return update_memory_result_dto.to_primitives()

    async def __get_stored_file(self, primitives: dict[str, Any]) -> dict[str, Any]:
        store_file_result_dto = await self._store_file_service(
            StoreFileDto(
                project=primitives["project"],
                file_path=primitives["file_path"],
                memory_type=MemoryTypeEnum(primitives.get("type", _DEFAULT_FILE_MEMORY_TYPE)),
            )
        )
        return store_file_result_dto.to_primitives()

    def __get_memory_type_or_none(self, primitives: dict[str, Any]) -> MemoryTypeEnum | None:
        """`type` es opcional en varias tools: sin él, no se filtra."""
        memory_type = primitives.get("type")
        return MemoryTypeEnum(memory_type) if memory_type else None
