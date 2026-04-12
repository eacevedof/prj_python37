from enum import Enum
from typing import final


@final
class McpServerNameEnum(str, Enum):
    """MCP server identifiers for tool registration."""

    AZURE_DEVOPS_WORK_ITEMS = "azure-devops-workitems"
