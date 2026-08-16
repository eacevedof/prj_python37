from enum import Enum
from typing import final


@final
class McpServerNameEnum(str, Enum):
    """MCP server name."""

    FILE_CHECKER = "file-checker"
