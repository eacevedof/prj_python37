"""Servicio para crear audio MP3 con OpenAI Audio API."""

import base64
from typing import Self, final

from ddd.open_ai.application.create_mp3_openai.create_mp3_openai_dto import CreateMp3OpenaiDto
from ddd.open_ai.application.create_mp3_openai.create_mp3_openai_result_dto import CreateMp3OpenaiResultDto
from ddd.open_ai.domain.enums import (
    OpenaiTtsFormatEnum,
    OpenaiTtsModelEnum,
    OpenaiTtsVoiceEnum,
)
from ddd.open_ai.domain.exceptions.open_ai_exception import OpenAIException
from ddd.open_ai.infrastructure.repositories.openai_audio_api_repository import OpenaiAudioApiRepository


@final
class CreateMp3OpenaiService:
    """Use case to generate TTS audio with OpenAI Audio API."""

    MAX_TEXT_LENGTH: int = 4096
    MIN_SPEED: float = 0.25
    MAX_SPEED: float = 4.0

    _MIME_TYPES: dict[str, str] = {
        "mp3": "audio/mpeg",
        "opus": "audio/opus",
        "aac": "audio/aac",
        "flac": "audio/flac",
        "wav": "audio/wav",
        "pcm": "audio/pcm",
    }

    _create_mp3_openai_dto: CreateMp3OpenaiDto
    _audio_repository: OpenaiAudioApiRepository

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __init__(self) -> None:
        self._audio_repository = OpenaiAudioApiRepository.get_instance()

    def __call__(
        self,
        create_mp3_openai_dto: CreateMp3OpenaiDto
    ) -> CreateMp3OpenaiResultDto:
        """
        Generates TTS audio with OpenAI according to DTO parameters.

        Returns:
            CreateMp3OpenaiResultDto: Result DTO with generated audio

        Raises:
            OpenAIException: If parameter validation or generation fails
        """
        self._create_mp3_openai_dto = create_mp3_openai_dto

        self._fail_if_wrong_input()

        response = self._audio_repository.generate_speech(
            model=self._create_mp3_openai_dto.tts_model,
            voice=self._create_mp3_openai_dto.voice,
            input_text=self._create_mp3_openai_dto.text.strip(),
            speed=self._create_mp3_openai_dto.speed,
            response_format=self._create_mp3_openai_dto.response_format,
        )

        audio_bytes = response.content
        if not audio_bytes:
            raise OpenAIException.unexpected_custom("No audio data received from OpenAI API")

        audio_b64 = base64.b64encode(audio_bytes).decode("utf-8")

        return CreateMp3OpenaiResultDto.from_primitives({
            "audio_b64": audio_b64,
            "mime_type": self._get_mime_type(),
            "text": self._create_mp3_openai_dto.text.strip(),
            "model": self._create_mp3_openai_dto.tts_model,
            "voice": self._create_mp3_openai_dto.voice,
            "speed": self._create_mp3_openai_dto.speed,
            "format": self._create_mp3_openai_dto.response_format,
        })

    def _fail_if_wrong_input(self) -> None:
        if len(self._create_mp3_openai_dto.text) > self.MAX_TEXT_LENGTH:
            raise OpenAIException.unexpected_custom(f"text cannot exceed {self.MAX_TEXT_LENGTH} characters")

        if not self.MIN_SPEED <= self._create_mp3_openai_dto.speed <= self.MAX_SPEED:
            raise OpenAIException.unexpected_custom(
                f"speed must be between {self.MIN_SPEED} and {self.MAX_SPEED}"
            )

        valid_voices = [str(enum_item.value) for enum_item in OpenaiTtsVoiceEnum]
        if self._create_mp3_openai_dto.voice not in valid_voices:
            raise OpenAIException.unexpected_custom(
                f"Invalid voice: {self._create_mp3_openai_dto.voice}. Allowed values: {", ".join(valid_voices)}"
            )

        valid_models = [str(enum_item.value) for enum_item in OpenaiTtsModelEnum]
        if self._create_mp3_openai_dto.tts_model not in valid_models:
            raise OpenAIException.unexpected_custom(
                f"Invalid tts_model: {self._create_mp3_openai_dto.tts_model}. "
                f"Allowed values: {", ".join(valid_models)}"
            )

        valid_formats = [str(enum_item.value) for enum_item in OpenaiTtsFormatEnum]
        if self._create_mp3_openai_dto.response_format not in valid_formats:
            raise OpenAIException.unexpected_custom(
                f"Invalid response_format: {self._create_mp3_openai_dto.response_format}. "
                f"Allowed values: {", ".join(valid_formats)}"
            )

    def _get_mime_type(self) -> str:
        return self._MIME_TYPES.get(self._create_mp3_openai_dto.response_format, "audio/mpeg")
