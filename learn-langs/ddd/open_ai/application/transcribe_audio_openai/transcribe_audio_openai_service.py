"""Service for transcribing audio with OpenAI Whisper API."""

import os
from pathlib import Path
from typing import Self, final

from ddd.open_ai.domain.enums import (
    OpenaiAudioFileTypeEnum,
    OpenaiTranscriptionConstraintsEnum,
    OpenaiTranscriptionModelEnum,
    OpenaiTranscriptionResponseFormatEnum,
)
from ddd.open_ai.domain.exceptions.open_ai_exception import OpenAIException
from ddd.open_ai.infrastructure.repositories.gpt_whisper_1_reader_api_repository import GptWhisper1ReaderApiRepository
from ddd.open_ai.application.transcribe_audio_openai.transcribe_audio_openai_dto import TranscribeAudioOpenaiDto
from ddd.open_ai.application.transcribe_audio_openai.transcribe_audio_openai_result_dto import TranscribeAudioOpenaiResultDto


@final
class TranscribeAudioOpenaiService:
    """Use case to transcribe audio (speech-to-text) with OpenAI Whisper API."""

    _transcribe_audio_openai_dto: TranscribeAudioOpenaiDto
    _gpt_whisper_1_reader_api_repository: GptWhisper1ReaderApiRepository

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __init__(self) -> None:
        self._gpt_whisper_1_reader_api_repository = GptWhisper1ReaderApiRepository.get_instance()

    def __call__(
        self,
        transcribe_audio_openai_dto: TranscribeAudioOpenaiDto,
    ) -> TranscribeAudioOpenaiResultDto:
        self._transcribe_audio_openai_dto = transcribe_audio_openai_dto

        self._fail_if_wrong_input()

        transcribed_text = self._gpt_whisper_1_reader_api_repository.transcribe_audio_file(
            audio_file_path=self._transcribe_audio_openai_dto.audio_file_path,
            model=self._transcribe_audio_openai_dto.model,
            response_format=self._transcribe_audio_openai_dto.response_format,
            language=self._transcribe_audio_openai_dto.language,
        )

        return TranscribeAudioOpenaiResultDto.from_primitives({
            "transcribed_text": transcribed_text,
            "audio_file_path": self._transcribe_audio_openai_dto.audio_file_path,
            "model": self._transcribe_audio_openai_dto.model,
            "response_format": self._transcribe_audio_openai_dto.response_format,
            "language": self._transcribe_audio_openai_dto.language,
        })

    def _fail_if_wrong_input(self) -> None:
        audio_file_path = self._transcribe_audio_openai_dto.audio_file_path
        if not audio_file_path:
            OpenAIException.bad_request("audio_file_path cannot be empty")

        if not os.path.exists(audio_file_path):
            OpenAIException.not_found(f"Audio file not found: {audio_file_path}")

        file_size = os.path.getsize(audio_file_path)
        if file_size > OpenaiTranscriptionConstraintsEnum.MAX_FILE_SIZE_BYTES:
            OpenAIException.bad_request(
                f"File size {file_size / 1024 / 1024:.2f}MB exceeds limit of "
                f"{OpenaiTranscriptionConstraintsEnum.MAX_FILE_SIZE_MB}MB"
            )

        file_extension = Path(audio_file_path).suffix.lstrip(".").lower()
        valid_extensions = list(OpenaiAudioFileTypeEnum)
        if file_extension not in valid_extensions:
            OpenAIException.bad_request(
                f"Unsupported format '{file_extension}'. Allowed values: {', '.join(valid_extensions)}"
            )

        valid_formats = list(OpenaiTranscriptionResponseFormatEnum)
        if self._transcribe_audio_openai_dto.response_format not in valid_formats:
            OpenAIException.bad_request(
                f"Invalid response_format: {self._transcribe_audio_openai_dto.response_format}. "
                f"Allowed values: {', '.join(valid_formats)}"
            )

        valid_models = list(OpenaiTranscriptionModelEnum)
        if self._transcribe_audio_openai_dto.model not in valid_models:
            OpenAIException.bad_request(
                f"Invalid model: {self._transcribe_audio_openai_dto.model}. "
                f"Allowed values: {', '.join(valid_models)}"
            )
