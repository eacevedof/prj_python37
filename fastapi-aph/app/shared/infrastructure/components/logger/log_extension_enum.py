from enum import Enum
from typing import final


@final
class LogExtensionEnum(str, Enum):
    """Log file extension enumeration"""
    SQL = "sql"
    LOG = "log"