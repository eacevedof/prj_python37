from enum import Enum
from typing import final


@final
class ToolNameEnum(str, Enum):
    """MCP tool names exposed by the local devops server."""

    LOCAL_SETUP_PROJECT = "local_setup_project"
    LOCAL_GET_NEXT_PORT = "local_get_next_port"
