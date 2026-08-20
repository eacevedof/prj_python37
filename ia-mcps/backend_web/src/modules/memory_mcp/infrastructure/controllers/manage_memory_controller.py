from typing import Any, Self, final

from src.modules.shared.infrastructure.controllers.abstract_mcp_controller import AbstractMcpController

from src.modules.memory_mod.domain.exceptions import MemoryException

from src.modules.memory_mcp.domain.enums.mcp_server_name_enum import McpServerNameEnum
from src.modules.memory_mcp.domain.exceptions.memory_mcp_exception import MemoryMcpException
from src.modules.memory_mcp.infrastructure.repositories.tools_reader_in_memory_repository import (
    ToolsReaderInMemoryRepository,
)
from src.modules.memory_mcp.application.manage_memory.manage_memory_dto import ManageMemoryDto
from src.modules.memory_mcp.application.manage_memory.manage_memory_service import (
    ManageMemoryService,
)


@final
class ManageMemoryController(AbstractMcpController):
    """Endpoint MCP del módulo memory (streamable HTTP)."""

    _instance: "ManageMemoryController | None" = None

    _manage_memory_service: ManageMemoryService
    _tools_reader_in_memory_repository: ToolsReaderInMemoryRepository

    def __init__(self) -> None:
        super().__init__(McpServerNameEnum.MEMORY.value)
        self._manage_memory_service = ManageMemoryService.get_instance()
        self._tools_reader_in_memory_repository = ToolsReaderInMemoryRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def get_tool_schemas(self) -> list[dict[str, Any]]:
        return self._tools_reader_in_memory_repository.get_all()

    async def get_tool_text(self, tool_name: str, payload_dict: dict[str, Any]) -> str:
        manage_memory_result_dto = await self._manage_memory_service(
            ManageMemoryDto.from_primitives({
                "tool_name": tool_name,
                "arguments": payload_dict,
            })
        )
        return manage_memory_result_dto.text

    def get_domain_exception_types(self) -> tuple[type[Exception], ...]:
        return (MemoryMcpException, MemoryException)
