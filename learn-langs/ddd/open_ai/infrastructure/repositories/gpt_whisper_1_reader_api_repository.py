"""Repository for audio transcription (STT) with OpenAI Whisper API."""

from typing import final, Self

from ddd.open_ai.domain.enums import (
    OpenaiTranscriptionModelEnum,
    OpenaiTranscriptionResponseFormatEnum,
)
from ddd.open_ai.infrastructure.repositories.abstract_open_ai_api_repository import AbstractOpenAIApiRepository


@final
class GptWhisper1ReaderApiRepository(AbstractOpenAIApiRepository):
    """Repository for speech-to-text transcription using Whisper-1."""

    _instance: "GptWhisper1ReaderApiRepository | None" = None

    @classmethod
    def get_instance(cls) -> Self:
        """Returns the singleton instance."""
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def transcribe_audio_file(
        self,
        audio_file_path: str,
        model: str = OpenaiTranscriptionModelEnum.WHISPER_1,
        response_format: str = OpenaiTranscriptionResponseFormatEnum.TEXT,
        language: str | None = None,
    ) -> str:
        """Transcribes an audio file using OpenAI Whisper API. Input is validated upstream."""
        with open(audio_file_path, "rb") as audio_file:
            request_params = {
                "model": model,
                "file": audio_file,
                "response_format": response_format,
            }
            if language:
                request_params["language"] = language

            transcript = self._open_ai_client.audio.transcriptions.create(**request_params)

        if response_format == OpenaiTranscriptionResponseFormatEnum.TEXT:
            return str(transcript)
        return transcript
