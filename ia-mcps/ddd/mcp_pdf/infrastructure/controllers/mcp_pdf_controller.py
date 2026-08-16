import asyncio
from typing import final, Self

from mcp.server import Server
from mcp.server.stdio import stdio_server
from mcp.types import Tool, TextContent

from ddd.shared.infrastructure.components.logger import Logger
from ddd.mcp_pdf.domain.enums import McpServerNameEnum
from ddd.mcp_pdf.application import CallToolDto, ListToolsService, CallToolService


@final
class McpPdfController:
    """MCP Server controller for PDF conversion operations."""

    _logger: Logger
    _mcp_server: Server
    _list_tools_service: ListToolsService
    _call_tool_service: CallToolService

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._mcp_server = Server(McpServerNameEnum.PDF.value)
        self._list_tools_service = ListToolsService.get_instance()
        self._call_tool_service = CallToolService.get_instance()
        self.__register_services_as_handlers()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self) -> None:
        async with stdio_server() as (mcp_read_stream, mcp_write_stream):
            self._logger.log_info(module="mcp_pdf_controller", message="__call__")
            await self._mcp_server.run(
                mcp_read_stream,
                mcp_write_stream,
                self._mcp_server.create_initialization_options(),
            )

    def __register_services_as_handlers(self) -> None:
        self._logger.log_info(module="mcp_pdf_controller", message="_register_handlers")

        @self._mcp_server.list_tools()
        async def list_tools() -> list[Tool]:
            try:
                result_dto = await self._list_tools_service()
                return result_dto.to_list()
            except Exception as list_exception:
                self._logger.log_exception(list_exception, "mcp_pdf_controller.list_tools")
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
            except Exception as call_exception:
                self._logger.log_exception(
                    call_exception, f"mcp_pdf_controller.call_tool: {event_name}"
                )
                return [
                    TextContent(
                        type="text",
                        text="Unexpected internal error while executing tool.",
                    )
                ]


def start_mcp_or_fail() -> None:
    """Start the MCP server for PDF conversion operations."""
    try:
        asyncio.run(McpPdfController.get_instance()())
    except BaseException as base_exception:
        Logger.get_instance().log_exception(
            base_exception,
            "mcp_pdf_controller.start_mcp: Unhandled error",
        )
        raise
