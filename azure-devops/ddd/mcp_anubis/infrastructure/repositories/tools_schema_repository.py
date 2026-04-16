from typing import final, Self

from mcp.types import Tool

from ddd.mcp_anubis.domain.enums import ToolNameEnum


@final
class ToolsSchemaRepository:
    """Repository for Anubis MCP tool schemas."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_all_tools(self) -> list[Tool]:
        return [
            self._request_anubis_schema(),
        ]

    def _request_anubis_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.REQUEST_ANUBIS.value,
            description=(
                "execute SQL queries against Anubis API. "
                "IMPORTANT: write operations (INSERT, UPDATE, DELETE, etc.) require confirmation. "
                "If requires_confirmation is true, you must show the query to the user and ask for 'yes' or 'no' confirmation."
            ),
            inputSchema={
                "type": "object",
                "properties": {
                    "sql": {
                        "type": "string",
                        "description": "SQL query to execute against Anubis database",
                    },
                    "confirmed": {
                        "type": "boolean",
                        "description": "set to true only after user explicitly confirms a write operation with 'yes'",
                        "default": False,
                    },
                },
                "required": ["sql"],
            },
        )
