from enum import Enum

class LogLevelEnum(Enum):
    INFO = "info"
    DEBUG = "debug"
    ERROR = "error"
    WARNING = "warning"
    SECURITY = "security"
    SQL = "sql"
    TRACKING = "tracking"