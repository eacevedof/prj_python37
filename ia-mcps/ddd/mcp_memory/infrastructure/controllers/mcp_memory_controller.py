import json
from typing import Any, final, Self

from mcp.server import Server
from mcp.server.stdio import stdio_server
from mcp.types import Tool, TextContent

from ddd.shared.infrastructure.components import Logger
from ddd.mcp_memory.application import ListToolsService, ListToolsDto, CallToolService, CallToolDto


@final
class McpMemoryController:

	_logger: Logger
	_list_tools_service: ListToolsService
	_call_tool_service: CallToolService
	_instance: "McpMemoryController | None" = None

	def __init__(self) -> None:
		self._logger = Logger.get_instance()
		self._list_tools_service = ListToolsService.get_instance()
		self._call_tool_service = CallToolService.get_instance()
		self._server = Server("mcp-memory")
		self._setup_handlers()

	@classmethod
	def get_instance(cls) -> Self:
		if cls._instance is None:
			cls._instance = cls()
		return cls._instance

	def _setup_handlers(self) -> None:
		@self._server.list_tools()
		async def list_tools() -> list[Tool]:
			result = await self._list_tools_service(ListToolsDto())
			return [Tool(**tool) for tool in result["tools"]]

		@self._server.call_tool()
		async def call_tool(name: str, arguments: dict[str, Any]) -> list[TextContent]:
			try:
				result = await self._call_tool_service(CallToolDto(tool_name=name, tool_arguments=arguments))
				return [TextContent(type="text", text=json.dumps(result, indent=2))]
			except Exception as e:
				self._logger.log_payload_error(
					{"name": name, "args": arguments},
					"call_tool.error"
				)
				error_response = {"error": str(e)}
				return [TextContent(type="text", text=json.dumps(error_response, indent=2))]

	async def run(self) -> None:
		async with stdio_server() as (read_stream, write_stream):
			await self._server.run(read_stream, write_stream, self._server.create_initialization_options())
