from enum import Enum
from typing import final


@final
class GraphApiEnum(str, Enum):
    """Microsoft Graph API endpoints for calendar operations."""

    BASE_URL = "https://graph.microsoft.com/v1.0"
