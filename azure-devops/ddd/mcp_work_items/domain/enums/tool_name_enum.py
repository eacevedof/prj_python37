from enum import Enum
from typing import final


@final
class ToolNameEnum(str, Enum):
    """MCP tool names exposed by the work items server."""

    WI_CREATE_EPIC = "create_wi_epic"
    WI_CREATE_TASK = "create_wi_task"
    WI_GET_TASKS = "get_tasks"
    WI_UPDATE_TASK = "update_task"
    WI_SEARCH = "search_work_items"
    WI_GET_DETAIL = "get_work_item_detail"
