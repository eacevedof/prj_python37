from enum import Enum
from typing import final


@final
class McpServerNameEnum(str, Enum):
    """MCP server names."""

    EMT = "emt"
