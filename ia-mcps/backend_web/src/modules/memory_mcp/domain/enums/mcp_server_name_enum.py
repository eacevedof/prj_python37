from enum import Enum


class McpServerNameEnum(str, Enum):
    """Nombre con el que este servidor MCP se presenta al cliente."""

    MEMORY = "memory"
