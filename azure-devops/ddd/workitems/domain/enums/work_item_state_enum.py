from enum import Enum
from typing import final


@final
class WorkItemStateEnum(str, Enum):
    NEW = "New"
    ACTIVE = "Active"
    RESOLVED = "Resolved"
    CLOSED = "Closed"
    REMOVED = "Removed"
