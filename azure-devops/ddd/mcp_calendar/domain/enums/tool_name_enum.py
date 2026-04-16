from enum import Enum
from typing import final


@final
class ToolNameEnum(str, Enum):
    """MCP tool names exposed by the Calendar server."""

    LIST_CAL_EVENTS = "list_cal_events"
    GET_CAL_EVENT = "get_cal_event"
    CREATE_CAL_EVENT = "create_cal_event"
    UPDATE_CAL_EVENT = "update_cal_event"
    DELETE_CAL_EVENT = "delete_cal_event"
    ADD_CAL_HOLIDAY = "add_cal_holiday"
