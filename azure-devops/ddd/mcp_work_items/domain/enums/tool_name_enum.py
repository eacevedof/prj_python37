from enum import Enum
from typing import final


@final
class ToolNameEnum(str, Enum):
    WI_CREATE_EPIC = "create_wi_epic"
    WI_CREATE_TASK = "create_wi_task"
    WI_GET_TASKS = "get_tasks"
    WI_UPDATE_TASK = "update_task"
