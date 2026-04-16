from typing import final, Self

from ddd.mcp_hashed_pwd.application.list_tools.list_tools_result_dto import (
    ListToolsResultDto,
)
from ddd.mcp_hashed_pwd.infrastructure.repositories.tools_schema_repository import (
    ToolsSchemaRepository,
)


@final
class ListToolsService:
    """Service that returns available MCP tools for password hashing."""

    def __init__(self) -> None:
        self._tools_schema_repository = ToolsSchemaRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self) -> ListToolsResultDto:
        tools = self._tools_schema_repository.get_all_tools()
        return ListToolsResultDto.from_primitives({"tools": tools})
