import json
from typing import final, Self, Any

from mcp.types import TextContent

from ddd.shared.infrastructure.components.logger import Logger
from ddd.mcp_admin_loc_mysql.domain.enums import ToolNameEnum
from ddd.mcp_admin_loc_mysql.application.call_tool.call_tool_dto import CallToolDto
from ddd.mcp_admin_loc_mysql.application.call_tool.call_tool_result_dto import (
    CallToolResultDto,
)
from ddd.devops.application import (
    AdminLocMysqlDto,
    AdminLocMysqlService,
)


@final
class CallToolService:
    """Service that routes MCP tool calls to MySQL admin operations."""

    _logger: Logger
    _payload_dict: dict[str, Any]

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._payload_dict = {}

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, call_tool_dto: CallToolDto) -> CallToolResultDto:
        self._payload_dict = call_tool_dto.payload_dict

        try:
            if call_tool_dto.event_name == ToolNameEnum.MYSQL_LIST_DATABASES.value:
                text_contents = await self.__handle_list_databases()

            elif call_tool_dto.event_name == ToolNameEnum.MYSQL_SHOW_TABLES.value:
                text_contents = await self.__handle_show_tables()

            elif call_tool_dto.event_name == ToolNameEnum.MYSQL_DESCRIBE_TABLE.value:
                text_contents = await self.__handle_describe_table()

            elif call_tool_dto.event_name == ToolNameEnum.MYSQL_EXECUTE_QUERY.value:
                text_contents = await self.__handle_execute_query()

            else:
                text_contents = [
                    TextContent(
                        type="text", text=f"unknown tool: {call_tool_dto.event_name}"
                    )
                ]

        except Exception as e:
            self._logger.write_error(
                module="CallToolService.__call__",
                message=str(e),
                context={
                    "tool": call_tool_dto.event_name,
                    "payload": self._payload_dict,
                },
            )
            text_contents = [TextContent(type="text", text=f"error: {str(e)}")]

        return CallToolResultDto.from_primitives({"contents": text_contents})

    async def __handle_list_databases(self) -> list[TextContent]:
        dto = AdminLocMysqlDto.from_primitives(
            {
                "action": "list_databases",
                "database": "",
                "table": "",
                "query": "",
            }
        )
        result = await AdminLocMysqlService.get_instance()(dto)
        return self.__format_result(result)

    async def __handle_show_tables(self) -> list[TextContent]:
        dto = AdminLocMysqlDto.from_primitives(
            {
                "action": "show_tables",
                "database": self._payload_dict.get("database", ""),
                "table": "",
                "query": "",
            }
        )
        result = await AdminLocMysqlService.get_instance()(dto)
        return self.__format_result(result)

    async def __handle_describe_table(self) -> list[TextContent]:
        dto = AdminLocMysqlDto.from_primitives(
            {
                "action": "describe_table",
                "database": self._payload_dict.get("database", ""),
                "table": self._payload_dict.get("table", ""),
                "query": "",
            }
        )
        result = await AdminLocMysqlService.get_instance()(dto)
        return self.__format_result(result)

    async def __handle_execute_query(self) -> list[TextContent]:
        dto = AdminLocMysqlDto.from_primitives(
            {
                "action": "execute_query",
                "database": self._payload_dict.get("database", ""),
                "table": "",
                "query": self._payload_dict.get("query", ""),
            }
        )
        result = await AdminLocMysqlService.get_instance()(dto)
        return self.__format_result(result)

    def __format_result(self, result: Any) -> list[TextContent]:
        """Format the result DTO as a readable text response."""
        if not result.success:
            return [TextContent(type="text", text=f"error: {result.message}")]

        lines = [result.message]

        if result.data:
            lines.append("")
            lines.append(json.dumps(result.data, indent=2, ensure_ascii=False))

        return [TextContent(type="text", text="\n".join(lines))]
