from typing import final, Self

from ddd.mcp_file_checker.application.list_tools.list_tools_result_dto import ListToolsResultDto
from ddd.mcp_file_checker.infrastructure.repositories.tools_schema_repository import (
    ToolsSchemaRepository,
)


@final
class ListToolsService:
    """Service for listing available MCP tools."""

    def __init__(self) -> None:
        self._tools_schema_repository = ToolsSchemaRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self) -> ListToolsResultDto:
        """List all available file_checker MCP tools.

        Returns:
            ListToolsResultDto with tool schemas.
        """
        tools = self._tools_schema_repository.get_all_file_checker_tools()
        return ListToolsResultDto.from_primitives({"tools": tools})
