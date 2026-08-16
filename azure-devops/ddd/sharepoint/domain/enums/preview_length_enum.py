from enum import IntEnum
from typing import final


@final
class PreviewLengthEnum(IntEnum):
    """Character limits for previewing SharePoint content in tool responses."""

    CONTENT_BASE64 = 100
