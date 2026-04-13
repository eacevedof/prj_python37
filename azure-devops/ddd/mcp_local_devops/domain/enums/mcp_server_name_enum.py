from enum import Enum
from typing import final


@final
class McpServerNameEnum(str, Enum):
    """MCP server name for local devops."""

    LOCAL_DEVOPS = "local-devops"
