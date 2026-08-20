from enum import Enum


class ToolNameEnum(str, Enum):
    """Tools que publica el servidor MCP de memory."""

    STORE = "memory_store"
    SEARCH = "memory_search"
    CHECK_FRESHNESS = "memory_check_freshness"
    LIST = "memory_list"
    DELETE = "memory_delete"
    UPDATE = "memory_update"
    STORE_FILE = "memory_store_file"
