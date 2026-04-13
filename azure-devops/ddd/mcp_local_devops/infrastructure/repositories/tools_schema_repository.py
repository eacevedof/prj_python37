from typing import final, Self

from mcp.types import Tool

from ddd.mcp_local_devops.domain.enums import ToolNameEnum


@final
class ToolsSchemaRepository:

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_all_tools(self) -> list[Tool]:
        return [
            self._get_setup_project_schema(),
            self._get_next_port_schema(),
        ]

    def _get_setup_project_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.LOCAL_SETUP_PROJECT.value,
            description="setup a new local php project: clone repo, configure apache virtualhost, create mysql database, add hosts entry, create .env file, and restart apache",
            inputSchema={
                "type": "object",
                "properties": {
                    "project_name": {
                        "type": "string",
                        "description": "project name (will be normalized to lowercase with hyphens)",
                    },
                    "repo_url": {
                        "type": "string",
                        "description": "git clone url from azure devops",
                    },
                    "db_name": {
                        "type": "string",
                        "description": "mysql database name (default: ci_{project_name})",
                        "default": "",
                    },
                    "port": {
                        "type": "integer",
                        "description": "port number (default: auto-detect next available)",
                    },
                },
                "required": ["project_name", "repo_url"],
            },
        )

    def _get_next_port_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.LOCAL_GET_NEXT_PORT.value,
            description="get the next available port number by scanning ci-apps.conf",
            inputSchema={
                "type": "object",
                "properties": {},
                "required": [],
            },
        )
