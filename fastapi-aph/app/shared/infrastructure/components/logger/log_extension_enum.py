from enum import Enum


class LogExtensionEnum(str, Enum):
    """Log file extension enumeration"""
    SQL = "sql"
    LOG = "log"