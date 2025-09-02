from enum import Enum
from typing import final


@final
class HttpRequestMethodEnum(Enum):
    POST = "POST"
    GET = "GET"
    PUT = "PUT"
    DELETE = "DELETE"
    OPTIONS = "OPTIONS"
    HEAD = "HEAD"
    TRACE = "TRACE"
    PATCH = "PATCH"
    CONNECT = "CONNECT"
    ALL = "ALL"
    UNKNOWN = "UNKNOWN"