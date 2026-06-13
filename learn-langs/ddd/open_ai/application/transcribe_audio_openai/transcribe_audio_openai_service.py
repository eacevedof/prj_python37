"""Service for transcribing audio with OpenAI Whisper API."""

from typing import Self, final

from ddd.open_ai.application.transcribe_audio_openai.transcribe_audio_openai_dto import TranscribeAudioOpenaiDto
from ddd.open_ai.application.transcribe_audio_openai.transcribe_audio_openai_result_dto import TranscribeAudioOpenaiResultDto
from ddd.open_ai.domain.enums import OpenaiTranscriptionResponseFormatEnum
from ddd.open_ai.domain.exceptions.open_ai_exception import OpenAIException
from ddd.open_ai.infrastructure.repositories.gpt_whisper_1_reader_api_repository import GptWhisper1ReaderApiRepository


@final
class TranscribeAudioOpenaiService:
    """Use case to transcribe audio (speech-to-text) with OpenAI Whisper API."""

    _transcribe_audio_openai_dto: TranscribeAudioOpenaiDto
    _whisper_repository: GptWhisper1ReaderApiRepository

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __init__(self) -> None:
        self._whisper_repository = GptWhisper1ReaderApiRepository.get_instance()

    def __call__(
        self,
        transcribe_audio_openai_dto: TranscribeAudioOpenaiDto
    ) -> TranscribeAudioOpenaiResultDto:
        """
        Transcribes audio file to text using OpenAI Whisper according to DTO parameters.

        Returns:
            TranscribeAudioOpenaiResultDto: Result DTO with transcribed text

        Raises:
            OpenAIException: If parameter validation or transcription fails
        """
        self._transcribe_audio_openai_dto = transcribe_audio_openai_dto

        self._fail_if_wrong_input()

        transcribed_text = self._whisper_repository.transcribe_audio_file(
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
        """Validates input parameters."""
        valid_formats = list(OpenaiTranscriptionResponseFormatEnum)
        if self._transcribe_audio_openai_dto.response_format not in valid_formats:
            raise OpenAIException.unexpected_custom(
                f"Invalid response_format: {self._transcribe_audio_openai_dto.response_format}. "
                f"Allowed values: {', '.join(valid_formats)}"
            )

        # Validate model (currently only whisper-1 is available)
        if self._transcribe_audio_openai_dto.model != "whisper-1":
            raise OpenAIException.unexpected_custom(
                f"Invalid model: {self._transcribe_audio_openai_dto.model}. "
                f"Only 'whisper-1' is supported"
            )
