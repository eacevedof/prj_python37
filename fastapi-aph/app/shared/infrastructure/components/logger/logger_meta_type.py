from typing import final
from dataclasses import dataclass


@final
@dataclass(frozen=True)
class LoggerMetaType:
    """Logger metadata type for request context"""
    request_ip: str
    request_uri: str