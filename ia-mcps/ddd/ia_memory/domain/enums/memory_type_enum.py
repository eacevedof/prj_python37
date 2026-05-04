from enum import Enum
from typing import final


@final
class MemoryTypeEnum(str, Enum):
    """Types of memory chunks for project documentation."""

    MODULE = "module"
    APPLICATION = "application"
    DOMAIN = "domain"
    INFRASTRUCTURE = "infrastructure"
    PERSISTENCE = "persistence"
    DOCUMENTATION = "documentation"
