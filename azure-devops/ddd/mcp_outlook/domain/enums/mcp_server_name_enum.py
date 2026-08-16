from enum import Enum
from typing import final


@final
class McpServerNameEnum(str, Enum):
    """MCP server identifiers for Outlook tools."""

    OUTLOOK = "outlook"
