from enum import Enum
from typing import final


@final
class ToolNameEnum(str, Enum):
    MEMORY_STORE = "memory_store"
    MEMORY_SEARCH = "memory_search"
    MEMORY_CHECK_FRESHNESS = "memory_check_freshness"
    MEMORY_LIST = "memory_list"
    MEMORY_DELETE = "memory_delete"
    MEMORY_UPDATE = "memory_update"
    MEMORY_STORE_FILE = "memory_store_file"
