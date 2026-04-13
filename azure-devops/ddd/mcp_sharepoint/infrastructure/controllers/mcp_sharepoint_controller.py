import asyncio
import traceback
from typing import final, Self

from mcp.server import Server
from mcp.server.stdio import stdio_server
from mcp.types import Tool, TextContent

from ddd.shared.infrastructure.components.logger import Logger
from ddd.mcp_sharepoint.domain.enums import McpServerNameEnum
from ddd.mcp_sharepoint.application import CallToolDto, ListToolsService, CallToolService


@final
class McpSharePointController:
    """MCP Server controller for SharePoint file operations."""

    _logger: Logger
    _mcp_server: Server
    _list_tools_service: ListToolsService
    _call_tool_service: CallToolService

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._mcp_server = Server(McpServerNameEnum.SHAREPOINT_FILES.value)
        self._list_tools_service = ListToolsService.get_instance()
        self._call_tool_service = CallToolService.get_instance()
        self.__register_services_as_handlers()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self) -> None:
        async with stdio_server() as (mcp_read_stream, mcp_write_stream):
            self._logger.write_info(
                module="mcp_sharepoint_controller",
                message="__call__"
            )
            await self._mcp_server.run(
                mcp_read_stream,
                mcp_write_stream,
                self._mcp_server.create_initialization_options(),
            )

    def __register_services_as_handlers(self) -> None:
        self._logger.write_info(
            module="mcp_sharepoint_controller",
            message="_register_handlers"
        )

        @self._mcp_server.list_tools()
        async def list_tools() -> list[Tool]:
            try:
                result_dto = await self._list_tools_service()
                return result_dto.to_list()
            except Exception as e:
                self.__log_exception(
                    module="mcp_sharepoint_controller._register_handlers.list_tools",
                    base_exception=e
                )
                return []

        @self._mcp_server.call_tool()
        async def call_tool(event_name: str, payload_dict: dict) -> list[TextContent]:
            try:
                result_dto = await self._call_tool_service(
                    CallToolDto.from_primitives({
                        "event_name": event_name,
                        "arguments": payload_dict,
                    })
                )
                return result_dto.to_list()
            except Exception as e:
                self.__log_exception(
                    module="mcp_sharepoint_controller._register_handlers.call_tool",
                    base_exception=e,
                    context={"event_name": event_name, "arguments": payload_dict},
                )
                return [
                    TextContent(
                        type="text",
                        text="Unexpected internal error while executing tool.",
                    )
                ]

    def __log_exception(
        self,
        module: str,
        base_exception: BaseException,
        context: dict | None = None,
    ) -> None:
        error_traceback = "".join(
            traceback.format_exception(type(base_exception), base_exception, base_exception.__traceback__)
        )
        self._logger.write_error(
            module=module,
            message=f"{type(base_exception).__name__}: {base_exception}\n{error_traceback}",
            context=context,
        )


def start_mcp_or_fail() -> None:
    """Start the MCP server for SharePoint file operations."""
    try:
        asyncio.run(McpSharePointController.get_instance()())
    except BaseException as error:
        Logger.get_instance().write_error(
            module="mcp_sharepoint_controller.start_mcp",
            message=(
                f"Unhandled error: {type(error).__name__}: {error}\n"
                f"{"".join(traceback.format_exception(type(error), error, error.__traceback__))}"
            ),
        )
        raise


if __name__ == "__main__":
    start_mcp_or_fail()
