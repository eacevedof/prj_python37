from typing import TypedDict


class LoggerMetaType(TypedDict):
    """Logger metadata type for request context"""
    request_ip: str
    request_uri: str