from typing import final, Self

from ddd.mcp_calendar.application.list_tools.list_tools_result_dto import (
    ListToolsResultDto,
)
from ddd.mcp_calendar.infrastructure.repositories.tools_schema_reader_in_memory_repository import (
    ToolsSchemaReaderInMemoryRepository,
)


@final
class ListToolsService:
    """Service that returns available MCP tools for Calendar operations."""

    _tools_schema_repository: ToolsSchemaReaderInMemoryRepository

    def __init__(self) -> None:
        self._tools_schema_repository = ToolsSchemaReaderInMemoryRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self) -> ListToolsResultDto:
        tools = self._tools_schema_repository.get_all_calendar_tools()
        return ListToolsResultDto.from_primitives({"tools": tools})
