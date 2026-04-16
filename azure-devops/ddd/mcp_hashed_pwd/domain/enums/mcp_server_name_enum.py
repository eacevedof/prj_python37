from enum import Enum
from typing import final


@final
class McpServerNameEnum(str, Enum):
    """MCP server identifiers for Hashed Password tools."""

    HASHED_PWD = "hashed-pwd"
