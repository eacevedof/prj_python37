from enum import Enum
from typing import final


@final
class ToolNameEnum(str, Enum):
    """MCP tool names exposed by the Media server."""

    CREATE_IMAGE = "media_create_image"
    CREATE_AUDIO = "media_create_audio"
