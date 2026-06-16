"""Service for creating MP3 audio with OpenAI Audio API."""

import base64
from typing import Self, final

from ddd.open_ai.domain.enums import (
    OpenaiTtsFormatEnum,
    OpenaiTtsModelEnum,
    OpenaiTtsVoiceEnum,
    OpenaiTtsMimeTypeEnum,
    OpenaiTtsConstraintsEnum,
)
from ddd.open_ai.domain.exceptions.open_ai_exception import OpenAIException
from ddd.open_ai.infrastructure.repositories.gpt_tts_1_reader_api_repository import GptTts1ReaderApiRepository
from ddd.open_ai.application.create_mp3_openai.create_mp3_openai_dto import CreateMp3OpenaiDto
from ddd.open_ai.application.create_mp3_openai.create_mp3_openai_result_dto import CreateMp3OpenaiResultDto


@final
class CreateMp3OpenaiService:
    """Use case to generate text-to-speech audio with OpenAI Audio API."""

    _create_mp3_openai_dto: CreateMp3OpenaiDto
    _gpt_tts_1_reader_api_repository: GptTts1ReaderApiRepository

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __init__(self) -> None:
        self._gpt_tts_1_reader_api_repository = GptTts1ReaderApiRepository.get_instance()

    def __call__(
        self,
        create_mp3_openai_dto: CreateMp3OpenaiDto,
    ) -> CreateMp3OpenaiResultDto:
        self._create_mp3_openai_dto = create_mp3_openai_dto

        self._fail_if_wrong_input()

        audio_bytes = self._gpt_tts_1_reader_api_repository.get_audio_bytes_from_text(
            model=self._create_mp3_openai_dto.tts_model,
            voice=self._create_mp3_openai_dto.voice,
            input_text=self._create_mp3_openai_dto.text.strip(),
            speed=self._create_mp3_openai_dto.speed,
            response_format=self._create_mp3_openai_dto.response_format,
        )

        return CreateMp3OpenaiResultDto.from_primitives({
            "audio_b64": base64.b64encode(audio_bytes).decode("utf-8"),
            "mime_type": OpenaiTtsMimeTypeEnum.get_mime_type_by_format(
                self._create_mp3_openai_dto.response_format
            ),
            "text": self._create_mp3_openai_dto.text.strip(),
            "model": self._create_mp3_openai_dto.tts_model,
            "voice": self._create_mp3_openai_dto.voice,
            "speed": self._create_mp3_openai_dto.speed,
            "format": self._create_mp3_openai_dto.response_format,
        })

    def _fail_if_wrong_input(self) -> None:
        if not self._create_mp3_openai_dto.text.strip():
            OpenAIException.bad_request("text cannot be empty")

        max_text_length = OpenaiTtsConstraintsEnum.MAX_TEXT_LENGTH.value
        if len(self._create_mp3_openai_dto.text) > max_text_length:
            OpenAIException.bad_request(f"text cannot exceed {max_text_length} characters")

        min_speed = OpenaiTtsConstraintsEnum.MIN_SPEED.value
        max_speed = OpenaiTtsConstraintsEnum.MAX_SPEED.value
        if not min_speed <= self._create_mp3_openai_dto.speed <= max_speed:
            OpenAIException.bad_request(f"speed must be between {min_speed} and {max_speed}")

        valid_voices = list(OpenaiTtsVoiceEnum)
        if self._create_mp3_openai_dto.voice not in valid_voices:
            OpenAIException.bad_request(
                f"Invalid voice: {self._create_mp3_openai_dto.voice}. "
                f"Allowed values: {', '.join(valid_voices)}"
            )

        valid_models = list(OpenaiTtsModelEnum)
        if self._create_mp3_openai_dto.tts_model not in valid_models:
            OpenAIException.bad_request(
                f"Invalid tts_model: {self._create_mp3_openai_dto.tts_model}. "
                f"Allowed values: {', '.join(valid_models)}"
            )

        valid_formats = list(OpenaiTtsFormatEnum)
        if self._create_mp3_openai_dto.response_format not in valid_formats:
            OpenAIException.bad_request(
                f"Invalid response_format: {self._create_mp3_openai_dto.response_format}. "
                f"Allowed values: {', '.join(valid_formats)}"
            )
