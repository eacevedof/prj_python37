"""Repository for generating audio (TTS) with OpenAI Audio API."""

from typing import Self, final

from ddd.open_ai.domain.exceptions.open_ai_exception import OpenAIException
from ddd.open_ai.infrastructure.repositories.abstract_open_ai_api_repository import AbstractOpenAIApiRepository


@final
class GptTts1ReaderApiRepository(AbstractOpenAIApiRepository):
    """Repository for text-to-speech audio generation using OpenAI Audio API."""

    _instance: "GptTts1ReaderApiRepository | None" = None

    @classmethod
    def get_instance(cls) -> Self:
        """Returns the singleton instance."""
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def get_audio_bytes_from_text(
        self,
        model: str,
        voice: str,
        input_text: str,
        speed: float,
        response_format: str,
    ) -> bytes:
        """
        Generates audio using OpenAI Audio API.

        Args:
            model: Text-to-speech model (tts-1, tts-1-hd)
            voice: Voice (alloy, echo, fable, onyx, nova, shimmer)
            input_text: Text to convert
            speed: Speed (0.25 to 4.0)
            response_format: Format (mp3, opus, aac, flac, wav, pcm)

        Returns:
            bytes: Audio in bytes format

        Raises:
            OpenAIException: If generation fails
        """
        audio_response = self._open_ai_client.audio.speech.create(
            model=model,
            voice=voice,
            input=input_text,
            speed=speed,
            response_format=response_format,
        )

        audio_bytes = audio_response.content
        if not audio_bytes:
            OpenAIException.unexpected_custom(
                "GptTts1ReaderApiRepository: No audio data received from OpenAI API"
            )

        return audio_bytes
