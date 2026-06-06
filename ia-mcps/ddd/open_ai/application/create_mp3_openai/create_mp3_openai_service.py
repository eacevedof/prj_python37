"""Servicio para crear audio MP3 con OpenAI Audio API."""

import base64
from typing import Self, final

from ddd.open_ai.application.create_mp3_openai.create_mp3_openai_dto import CreateMp3OpenaiDto
from ddd.open_ai.domain.exceptions.open_ai_exception import OpenAIException
from ddd.open_ai.infrastructure.repositories.abstract_open_ai_api_repository import AbstractOpenAIApiRepository


@final
class CreateMp3OpenaiService(AbstractOpenAIApiRepository):
    """Caso de uso para generar audio TTS con OpenAI Audio API."""

    _create_mp3_openai_dto: CreateMp3OpenaiDto
    _MIME_TYPES: dict[str, str] = {
        "mp3": "audio/mpeg",
        "opus": "audio/opus",
        "aac": "audio/aac",
        "flac": "audio/flac",
        "wav": "audio/wav",
        "pcm": "audio/pcm",
    }

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __call__(self, create_mp3_openai_dto: CreateMp3OpenaiDto) -> dict:
        """
        Genera audio TTS con OpenAI según parámetros del DTO.

        Returns:
            dict con estructura:
            {
                "audio_b64": str,
                "mime_type": str,
                "text": str,
                "model": str,
                "voice": str,
                "speed": float,
                "format": str,
            }

        Raises:
            OpenAIException: Si falla la generación o validación
        """
        self._create_mp3_openai_dto = create_mp3_openai_dto

        try:
            response = self._open_ai_client.audio.speech.create(
                model=self._create_mp3_openai_dto.model,
                voice=self._create_mp3_openai_dto.voice,
                input=self._create_mp3_openai_dto.text.strip(),
                speed=self._create_mp3_openai_dto.speed,
                response_format=self._create_mp3_openai_dto.response_format,
            )

            audio_bytes = response.content
            if not audio_bytes:
                raise OpenAIException.unexpected_custom(
                    "CreateMp3OpenaiService: No se recibió audio en la respuesta"
                )

            audio_b64 = base64.b64encode(audio_bytes).decode("utf-8")

            return {
                "audio_b64": audio_b64,
                "mime_type": self._get_mime_type(),
                "text": self._create_mp3_openai_dto.text.strip(),
                "model": self._create_mp3_openai_dto.model,
                "voice": self._create_mp3_openai_dto.voice,
                "speed": self._create_mp3_openai_dto.speed,
                "format": self._create_mp3_openai_dto.response_format,
            }

        except OpenAIException:
            raise
        except Exception as e:
            raise OpenAIException.unexpected_custom(
                f"CreateMp3OpenaiService: Error al generar audio: {str(e)}"
            )

    def _get_mime_type(self) -> str:
        return self._MIME_TYPES.get(self._create_mp3_openai_dto.response_format, "audio/mpeg")
