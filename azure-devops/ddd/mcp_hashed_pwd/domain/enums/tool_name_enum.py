from enum import Enum
from typing import final


@final
class ToolNameEnum(str, Enum):
    """MCP tool names exposed by the Hashed Password server."""

    GET_HASHED_PWD = "get_hashed_pwd"
