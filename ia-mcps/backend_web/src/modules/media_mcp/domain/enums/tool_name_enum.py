from enum import Enum


class ToolNameEnum(str, Enum):
    """Tools que publica el servidor MCP de media."""

    CREATE_IMAGE = "media_create_image"
    CREATE_AUDIO = "media_create_audio"
