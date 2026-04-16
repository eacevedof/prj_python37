from enum import Enum
from typing import final


@final
class McpServerNameEnum(str, Enum):
    """MCP server identifiers for Calendar tools."""

    CALENDAR = "calendar"
