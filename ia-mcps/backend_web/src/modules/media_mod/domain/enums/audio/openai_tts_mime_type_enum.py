from enum import StrEnum
from typing import final


@final
class OpenaiTtsMimeTypeEnum(StrEnum):
    """MIME types for OpenAI TTS audio formats."""

    MP3 = "audio/mpeg"
    OPUS = "audio/opus"
    AAC = "audio/aac"
    FLAC = "audio/flac"
    WAV = "audio/wav"
    PCM = "audio/pcm"

    @staticmethod
    def get_mime_type_by_format(format_name: str) -> str:
        """Get MIME type by format name.

        Args:
            format_name: Audio format (e.g., "mp3", "opus")

        Returns:
            MIME type string (defaults to "audio/mpeg" if format not found)
        """
        mime_map = {
            "mp3": OpenaiTtsMimeTypeEnum.MP3,
            "opus": OpenaiTtsMimeTypeEnum.OPUS,
            "aac": OpenaiTtsMimeTypeEnum.AAC,
            "flac": OpenaiTtsMimeTypeEnum.FLAC,
            "wav": OpenaiTtsMimeTypeEnum.WAV,
            "pcm": OpenaiTtsMimeTypeEnum.PCM,
        }
        return mime_map.get(format_name, OpenaiTtsMimeTypeEnum.MP3)
