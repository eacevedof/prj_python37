from enum import StrEnum
from typing import final


@final
class OpenaiImageResponseFormatEnum(StrEnum):
    """Formatos de respuesta disponibles para imágenes con OpenAI."""

    URL = "url"
    B64_JSON = "b64_json"
