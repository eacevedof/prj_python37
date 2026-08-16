from enum import IntEnum
from typing import final


@final
class PreviewLengthEnum(IntEnum):
    """Character limits for previewing calendar content in tool responses."""

    EVENT_BODY = 200
