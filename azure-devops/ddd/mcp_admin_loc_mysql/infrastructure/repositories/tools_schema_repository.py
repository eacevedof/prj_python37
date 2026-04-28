from typing import final, Self

from mcp.types import Tool

from ddd.mcp_admin_loc_mysql.domain.enums import ToolNameEnum


@final
class ToolsSchemaRepository:
    """Repository that provides MCP tool schemas for MySQL admin operations."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_all_tools(self) -> list[Tool]:
        return [
            self._get_list_databases_schema(),
            self._get_show_tables_schema(),
            self._get_describe_table_schema(),
            self._get_execute_query_schema(),
        ]

    def _get_list_databases_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.MYSQL_LIST_DATABASES.value,
            description="list all databases in the local MySQL server running in Docker",
            inputSchema={
                "type": "object",
                "properties": {},
                "required": [],
            },
        )

    def _get_show_tables_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.MYSQL_SHOW_TABLES.value,
            description="show all tables in a specific database",
            inputSchema={
                "type": "object",
                "properties": {
                    "database": {
                        "type": "string",
                        "description": "database name to list tables from",
                    },
                },
                "required": ["database"],
            },
        )

    def _get_describe_table_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.MYSQL_DESCRIBE_TABLE.value,
            description="describe the structure of a table (columns, types, keys)",
            inputSchema={
                "type": "object",
                "properties": {
                    "database": {
                        "type": "string",
                        "description": "database name",
                    },
                    "table": {
                        "type": "string",
                        "description": "table name to describe",
                    },
                },
                "required": ["database", "table"],
            },
        )

    def _get_execute_query_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.MYSQL_EXECUTE_QUERY.value,
            description="execute a SQL query on the local MySQL server. Use for SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER, DROP, etc.",
            inputSchema={
                "type": "object",
                "properties": {
                    "database": {
                        "type": "string",
                        "description": "database name (optional for queries that don't need a specific database)",
                        "default": "",
                    },
                    "query": {
                        "type": "string",
                        "description": "SQL query to execute",
                    },
                },
                "required": ["query"],
            },
        )
