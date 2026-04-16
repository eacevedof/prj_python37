from enum import Enum
from typing import final


@final
class ToolNameEnum(str, Enum):
    """MCP tool names exposed by the Calendar server."""

    CAL_LIST_EVENTS = "cal_list_events"
    CAL_GET_EVENT = "cal_get_event"
    CAL_CREATE_EVENT = "cal_create_event"
    CAL_UPDATE_EVENT = "cal_update_event"
    CAL_DELETE_EVENT = "cal_delete_event"
