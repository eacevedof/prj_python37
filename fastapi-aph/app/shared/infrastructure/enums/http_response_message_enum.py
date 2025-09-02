from enum import Enum
from typing import final

@final
class HttpResponseMessageEnum(Enum):
    OK = "OK"
    CREATED = "Created"
    BAD_REQUEST = "Bad Request"
    UNAUTHORIZED = "Unauthorized"
    FORBIDDEN = "Forbidden"
    NOT_FOUND = "Not Found"
    CONFLICT = "Conflict"
    INTERNAL_SERVER_ERROR = "Internal Server Error"