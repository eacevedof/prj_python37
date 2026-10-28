from enum import Enum
from typing import final


@final
class WorkItemFieldEnum(str, Enum):
    """Azure DevOps work item field reference names."""

    DESCRIPTION = "System.Description"
    ASSIGNED_TO = "System.AssignedTo"
    TAGS = "System.Tags"
    STATE = "System.State"
    TITLE = "System.Title"
    TARGET_DATE = "Microsoft.VSTS.Scheduling.TargetDate"
