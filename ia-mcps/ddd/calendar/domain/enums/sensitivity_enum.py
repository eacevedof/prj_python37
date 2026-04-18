from enum import Enum
from typing import final


@final
class SensitivityEnum(str, Enum):
    """Microsoft Graph calendar event sensitivity levels."""

    NORMAL = "normal"
    PERSONAL = "personal"
    PRIVATE = "private"
    CONFIDENTIAL = "confidential"
