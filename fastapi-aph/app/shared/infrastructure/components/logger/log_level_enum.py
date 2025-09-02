from enum import Enum
from typing import final


@final
class LogLevelEnum(str, Enum):
    """Log level enumeration"""
    INFO = "info"
    DEBUG = "debug"
    ERROR = "error"
    SECURITY = "security"
    WARNING = "warning"
    SQL = "sql"
    TRACKING = "tracking"