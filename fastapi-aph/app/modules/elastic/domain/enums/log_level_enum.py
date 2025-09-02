from enum import Enum
from typing import final

@final
class LogLevelEnum(Enum):
    INFO = "info"
    DEBUG = "debug"
    ERROR = "error"
    WARNING = "warning"
    SECURITY = "security"
    SQL = "sql"
    TRACKING = "tracking"