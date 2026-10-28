from enum import Enum
from typing import final


@final
class AzureApiEnum(str, Enum):
    """Azure DevOps REST API constant values."""

    API_VERSION = "7.0"
    API_VERSION_PREVIEW = "7.0-preview"
    LINK_TYPE_HIERARCHY_REVERSE = "System.LinkTypes.Hierarchy-Reverse"
