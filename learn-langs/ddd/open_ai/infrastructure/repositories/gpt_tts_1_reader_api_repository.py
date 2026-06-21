"""Repositorio para generar audio (TTS) con OpenAI Audio API (tts-1)."""

from typing import final, Self, Any

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
        instructions: str = "",
    ) -> bytes:
        """Generates audio using OpenAI Audio API. Input is validated upstream."""
        request_params: dict[str, Any] = {
            "model": model,
            "voice": voice,
            "input": input_text,
            "response_format": response_format,
        }
        # 'instructions' (acento/estilo) solo lo admite gpt-4o-mini-tts; 'speed'
        # solo tts-1/tts-1-hd. Por eso son mutuamente excluyentes.
        if instructions:
            request_params["instructions"] = instructions
        else:
            request_params["speed"] = speed

        audio_response = self._open_ai_client.audio.speech.create(**request_params)

        audio_bytes = audio_response.content
        if not audio_bytes:
            OpenAIException.unexpected_custom(
                "GptTts1ReaderApiRepository: No audio data received from OpenAI API"
            )

        return audio_bytes
