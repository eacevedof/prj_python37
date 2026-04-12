from typing import final, Self

from ddd.shared.infrastructure.components.logger import Logger
from ddd.mcp_work_items.application.list_tools.list_tools_result_dto import ListToolsResultDto
from ddd.mcp_work_items.infrastructure.repositories.tools_schema_repository import ToolsSchemaRepository


@final
class ListToolsService:
    """Service that returns available MCP tools for work item management."""

    _logger: Logger
    _tools_schema_repository: ToolsSchemaRepository

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._tools_schema_repository = ToolsSchemaRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self) -> ListToolsResultDto:
        tools = self._tools_schema_repository.get_all_work_items_tools()
        return ListToolsResultDto(tools=tools)
