import asyncio
from typing import final, Self

from mcp.server import Server
from mcp.server.stdio import stdio_server
from mcp.types import Tool, TextContent

from ddd.shared.infrastructure.components.logger import Logger
from ddd.mcp_emt.domain.enums import McpServerNameEnum
from ddd.mcp_emt.application import CallToolDto, ListToolsService, CallToolService


@final
class McpEmtController:
    """MCP Server controller for EMT Madrid operations."""

    _logger: Logger
    _mcp_server: Server
    _list_tools_service: ListToolsService
    _call_tool_service: CallToolService

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._mcp_server = Server(McpServerNameEnum.EMT.value)
        self._list_tools_service = ListToolsService.get_instance()
        self._call_tool_service = CallToolService.get_instance()
        self.__register_services_as_handlers()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self) -> None:
        async with stdio_server() as (mcp_read_stream, mcp_write_stream):
            self._logger.log_info(
                module="mcp_emt_controller", message="__call__"
            )
            await self._mcp_server.run(
                mcp_read_stream,
                mcp_write_stream,
                self._mcp_server.create_initialization_options(),
            )

    def __register_services_as_handlers(self) -> None:
        self._logger.log_info(
            module="mcp_emt_controller", message="_register_handlers"
        )

        @self._mcp_server.list_tools()
        async def list_tools() -> list[Tool]:
            try:
                result_dto = await self._list_tools_service()
                return result_dto.to_list()
            except Exception as e:
                self._logger.log_exception(
                    e,
                    "mcp_emt_controller.list_tools"
                )
                return []

        @self._mcp_server.call_tool()
        async def call_tool(event_name: str, payload_dict: dict) -> list[TextContent]:
            try:
                result_dto = await self._call_tool_service(
                    CallToolDto.from_primitives(
                        {
                            "event_name": event_name,
                            "arguments": payload_dict,
                        }
                    )
                )
                return result_dto.to_list()
            except Exception as e:
                self._logger.log_exception(
                    e,
                    f"mcp_emt_controller.call_tool: {event_name}"
                )
                return [
                    TextContent(
                        type="text",
                        text="Unexpected internal error while executing tool.",
                    )
                ]


def start_mcp_or_fail() -> None:
    """Start the MCP server for EMT Madrid operations."""
    try:
        asyncio.run(McpEmtController.get_instance()())
    except BaseException as e:
        Logger.get_instance().log_exception(
            e,
            "mcp_emt_controller.start_mcp: Unhandled error"
        )
        raise


if __name__ == "__main__":
    start_mcp_or_fail()
