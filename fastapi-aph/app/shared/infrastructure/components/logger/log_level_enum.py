from enum import Enum


class LogLevelEnum(str, Enum):
    """Log level enumeration"""
    INFO = "info"
    DEBUG = "debug"
    ERROR = "error"
    SECURITY = "security"
    WARNING = "warning"
    SQL = "sql"
    TRACKING = "tracking"