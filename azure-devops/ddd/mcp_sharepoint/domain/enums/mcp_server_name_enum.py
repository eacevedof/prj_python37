from enum import Enum
from typing import final


@final
class McpServerNameEnum(str, Enum):
    """MCP server identifiers for SharePoint tools."""

    SHAREPOINT_FILES = "sharepoint-files"
