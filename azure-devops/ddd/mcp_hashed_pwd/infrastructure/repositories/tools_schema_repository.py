from typing import final, Self

from mcp.types import Tool

from ddd.mcp_hashed_pwd.domain.enums import ToolNameEnum


@final
class ToolsSchemaRepository:
    """Repository for Hashed Password MCP tool schemas."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_all_tools(self) -> list[Tool]:
        return [
            self._get_hashed_pwd_schema(),
        ]

    def _get_hashed_pwd_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.GET_HASHED_PWD.value,
            description="generate argon2id hashed passwords compatible with PHP sodium_crypto_pwhash_str",
            inputSchema={
                "type": "object",
                "properties": {
                    "passwords": {
                        "type": "string",
                        "description": "password or multiple passwords separated by a delimiter",
                    },
                    "separator": {
                        "type": "string",
                        "description": "delimiter to split multiple passwords (optional, e.g., '%' or ',')",
                        "default": "",
                    },
                },
                "required": ["passwords"],
            },
        )
