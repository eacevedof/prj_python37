"""Repositorio para generar audio (TTS) con OpenAI Audio API (tts-1)."""

from typing import final, Self

from ddd.open_ai.domain.exceptions.open_ai_exception import OpenAIException
from ddd.open_ai.infrastructure.repositories.abstract_open_ai_api_repository import AbstractOpenAIApiRepository


@final
class GptTts1ReaderApiRepository(AbstractOpenAIApiRepository):
    """Repositorio para generación de audio/pronunciación usando tts-1."""

    _instance: "GptTts1ReaderApiRepository | None" = None

    @classmethod
    def get_instance(cls) -> Self:
        """Retorna la instancia singleton."""
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
        """Generates audio using OpenAI Audio API. Input is validated upstream."""
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
