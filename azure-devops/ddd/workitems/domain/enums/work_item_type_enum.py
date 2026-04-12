from enum import Enum
from typing import final


@final
class WorkItemTypeEnum(str, Enum):
    """Azure DevOps work item types."""

    EPIC = "Epic"
    FEATURE = "Feature"
    USER_STORY = "User Story"
    TASK = "Task"
    BUG = "Bug"
    ISSUE = "Issue"
