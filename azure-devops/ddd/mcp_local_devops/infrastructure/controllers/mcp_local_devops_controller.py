import asyncio
import traceback
from typing import final, Self

from mcp.server import Server
from mcp.server.stdio import stdio_server
from mcp.types import Tool, TextContent

from ddd.shared.infrastructure.components.logger import Logger
from ddd.mcp_local_devops.domain.enums import McpServerNameEnum
from ddd.mcp_local_devops.infrastructure.repositories.tools_schema_repository import ToolsSchemaRepository
from ddd.mcp_local_devops.application.call_tool import CallToolDto, CallToolService


@final
class McpLocalDevOpsController:
    """MCP Server controller for local DevOps automation."""

    _logger: Logger
    _server: Server
    _tools_schema_repository: ToolsSchemaRepository
    _call_tool_service: CallToolService

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._server = Server(McpServerNameEnum.LOCAL_DEVOPS.value)
        self._tools_schema_repository = ToolsSchemaRepository.get_instance()
        self._call_tool_service = CallToolService.get_instance()
        self.__register_handlers()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self) -> None:
        async with stdio_server() as (read_stream, write_stream):
            self._logger.write_info(
                module="McpLocalDevOpsController",
                message="Starting MCP Local DevOps server",
            )
            await self._server.run(
                read_stream,
                write_stream,
                self._server.create_initialization_options(),
            )

    def __register_handlers(self) -> None:
        self._logger.write_info(
            module="McpLocalDevOpsController",
            message="Registering handlers",
        )

        @self._server.list_tools()
        async def list_tools() -> list[Tool]:
            try:
                return self._tools_schema_repository.get_all_tools()
            except Exception as e:
                self.__log_exception(
                    module="McpLocalDevOpsController.list_tools",
                    base_exception=e,
                )
                return []

        @self._server.call_tool()
        async def call_tool(event_name: str, payload_dict: dict) -> list[TextContent]:
            try:
                call_tool_dto = CallToolDto.from_primitives({
                    "event_name": event_name,
                    "payload_dict": payload_dict,
                })
                result = await self._call_tool_service(call_tool_dto)
                return result.contents
            except Exception as e:
                self.__log_exception(
                    module="McpLocalDevOpsController.call_tool",
                    base_exception=e,
                    context={"event_name": event_name, "payload_dict": payload_dict},
                )
                return [
                    TextContent(
                        type="text",
                        text=f"Unexpected error: {str(e)}",
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
    """Start the MCP server for local DevOps automation."""
    try:
        asyncio.run(McpLocalDevOpsController.get_instance()())
    except BaseException as error:
        Logger.get_instance().write_error(
            module="McpLocalDevOpsController.start_mcp_or_fail",
            message=(
                f"Unhandled error: {type(error).__name__}: {error}\n"
                f"{"".join(traceback.format_exception(type(error), error, error.__traceback__))}"
            ),
        )
        raise


if __name__ == "__main__":
    start_mcp_or_fail()
