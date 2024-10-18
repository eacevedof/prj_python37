from dataclasses import dataclass
from enum import Enum
from typing import final


@final
@dataclass(frozen=True)
class HttpResponseCodeEnum(Enum):
    OK = 200
    CREATED = 201
    NO_CONTENT = 204
    BAD_REQUEST = 400
    UNAUTHORIZED = 401
    FORBIDDEN = 403
    NOT_FOUND = 404
    METHOD_NOT_ALLOWED = 405
    CONFLICT = 409
    UNPROCESSABLE_ENTITY = 422
    INTERNAL_SERVER_ERROR = 500
    SERVICE_UNAVAILABLE = 503