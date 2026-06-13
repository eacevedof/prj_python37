from typing import final, Self

from ddd.mcp_memory.infrastructure.repositories import ToolsSchemaRepository
from ddd.mcp_memory.application.list_tools.list_tools_dto import ListToolsDto
from ddd.mcp_memory.application.list_tools.list_tools_result_dto import ListToolsResultDto


@final
class ListToolsService:
	"""Retrieves available MCP tools."""

	_tools_repo: ToolsSchemaRepository

	def __init__(self) -> None:
		self._tools_repo = ToolsSchemaRepository.get_instance()

	@classmethod
	def get_instance(cls) -> Self:
		return cls()

	async def __call__(self, dto: ListToolsDto) -> dict:
		tools = self._tools_repo.get_tools()
		result = ListToolsResultDto.from_primitives({"tools": tools})
		return result.to_primitives()
