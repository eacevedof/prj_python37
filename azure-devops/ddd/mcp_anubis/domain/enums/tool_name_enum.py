from enum import Enum
from typing import final


@final
class ToolNameEnum(str, Enum):
    """MCP tool names exposed by the Anubis server."""

    REQUEST_ANUBIS = "request_anubis"
