from enum import StrEnum
from typing import final


@final
class OpenaiImageResponseFormatEnum(StrEnum):
    """Available response formats for images with OpenAI."""

    URL = "url"
    B64_JSON = "b64_json"
