import json
from typing import Any, Awaitable, Callable, Self, final

from src.modules.shared.domain.enums.validation_message_enum import ValidationMessageEnum
from src.modules.shared.infrastructure.components.schema_validator.schema_validator import SchemaValidator

from src.modules.memory_mod.infrastructure.adapters.memory_store_adapter import MemoryStoreAdapter

from src.modules.memory_mcp.domain.enums.tool_name_enum import ToolNameEnum
from src.modules.memory_mcp.domain.exceptions.memory_mcp_exception import MemoryMcpException
from src.modules.memory_mcp.domain.ports.memory_store import MemoryStore
from src.modules.memory_mcp.infrastructure.repositories.tools_reader_in_memory_repository import (
    ToolsReaderInMemoryRepository,
)
from src.modules.memory_mcp.application.manage_memory.manage_memory_dto import ManageMemoryDto
from src.modules.memory_mcp.application.manage_memory.manage_memory_result_dto import (
    ManageMemoryResultDto,
)

_JSON_INDENT = 2


@final
class ManageMemoryService:
    """Caso de uso de la fachada MCP: ejecutar una tool del servidor de memory.

    NO tiene lógica de negocio: valida el payload contra el schema publicado,
    enruta al caso de uso de `memory_mod` a través del puerto y devuelve el
    resultado.

    A diferencia del resto de fachadas, aquí la respuesta es **JSON**, no prosa:
    son 7 tools que devuelven listados, ids y marcas de frescura que el agente
    encadena entre llamadas (buscar -> actualizar por chunk_id). Redactarlo como
    texto obligaría al modelo a volver a parsearlo. Es el contrato que ya tenía
    el servidor stdio.
    """

    _schema_validator: SchemaValidator
    _tools_reader_in_memory_repository: ToolsReaderInMemoryRepository
    _memory_store: MemoryStore

    _manage_memory_dto: ManageMemoryDto

    def __init__(self) -> None:
        self._schema_validator = SchemaValidator.get_instance()
        self._tools_reader_in_memory_repository = ToolsReaderInMemoryRepository.get_instance()
        self._memory_store: MemoryStore = MemoryStoreAdapter.get_instance()

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
        corresponden 1:1 con los métodos del puerto."""
        port_call_by_tool_name: dict[str, Callable[[dict[str, Any]], Awaitable[dict[str, Any]]]] = {
            ToolNameEnum.STORE.value: self._memory_store.store_memory,
            ToolNameEnum.SEARCH.value: self._memory_store.search_memory,
            ToolNameEnum.CHECK_FRESHNESS.value: self._memory_store.check_freshness,
            ToolNameEnum.LIST.value: self._memory_store.list_memories,
            ToolNameEnum.DELETE.value: self._memory_store.delete_memory,
            ToolNameEnum.UPDATE.value: self._memory_store.update_memory,
            ToolNameEnum.STORE_FILE.value: self._memory_store.store_file,
        }
        port_call = port_call_by_tool_name.get(self._manage_memory_dto.tool_name)
        if port_call is None:
            MemoryMcpException.bad_request(f"unknown tool: {self._manage_memory_dto.tool_name}")
        return await port_call(self._manage_memory_dto.payload_dict)
