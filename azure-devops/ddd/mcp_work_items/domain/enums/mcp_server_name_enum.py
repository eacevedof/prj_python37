from enum import Enum
from typing import final


@final
class McpServerNameEnum(str, Enum):
    AZURE_DEVOPS_WORK_ITEMS = "azure-devops-workitems"
