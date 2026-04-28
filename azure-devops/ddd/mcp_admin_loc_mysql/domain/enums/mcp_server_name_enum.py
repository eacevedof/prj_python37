from enum import Enum
from typing import final


@final
class McpServerNameEnum(str, Enum):
    """MCP server name for admin loc mysql."""

    ADMIN_LOC_MYSQL = "admin-loc-mysql"
