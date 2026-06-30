from enum import IntEnum
from typing import final


@final
class HttpStatusEnum(IntEnum):
    """HTTP status codes handled by SharePoint Graph API requests."""

    NO_CONTENT = 204
    BAD_REQUEST = 400
    NOT_FOUND = 404
