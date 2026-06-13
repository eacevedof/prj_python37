"""Repository for audio transcription (STT) with OpenAI Whisper API."""

import os
from typing import final, Self

from ddd.open_ai.domain.exceptions.open_ai_exception import OpenAIException
from ddd.open_ai.infrastructure.repositories.abstract_open_ai_api_repository import AbstractOpenAIApiRepository


@final
class GptWhisper1ReaderApiRepository(AbstractOpenAIApiRepository):
    """Repository for speech-to-text transcription using Whisper-1."""

    _instance: "GptWhisper1ReaderApiRepository | None" = None

    # OpenAI API file size limit for audio files
    MAX_FILE_SIZE_MB = 25
    MAX_FILE_SIZE_BYTES = MAX_FILE_SIZE_MB * 1024 * 1024

    # Supported audio formats
    SUPPORTED_FORMATS = {
        ".mp3", ".mp4", ".mpeg", ".mpga", ".m4a", ".wav", ".webm"
    }

    @classmethod
    def get_instance(cls) -> Self:
        """Returns the singleton instance."""
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def transcribe_audio_file(
        self,
        audio_file_path: str,
        model: str = "whisper-1",
        response_format: str = "text",
        language: str | None = None,
    ) -> str:
        """
        Transcribes audio file using OpenAI Whisper API.

        Args:
            audio_file_path: Path to audio file to transcribe
            model: Model to use (default: whisper-1)
            response_format: Response format (text, json, verbose_json, srt, vtt)
            language: Optional ISO-639-1 language code (e.g., "en", "es", "nl")

        Returns:
            str: Transcribed text (or JSON/SRT/VTT if format specified)

        Raises:
            OpenAIException: If file validation or transcription fails
        """
        # Validate file exists
        if not os.path.exists(audio_file_path):
            raise OpenAIException.unexpected_custom(
                f"GptWhisper1ReaderApiRepository: Audio file not found: {audio_file_path}"
            )

        # Validate file size
        file_size = os.path.getsize(audio_file_path)
        if file_size > self.MAX_FILE_SIZE_BYTES:
            raise OpenAIException.unexpected_custom(
                f"GptWhisper1ReaderApiRepository: File size {file_size / 1024 / 1024:.2f}MB "
                f"exceeds limit of {self.MAX_FILE_SIZE_MB}MB"
            )

        # Validate file format
        file_ext = os.path.splitext(audio_file_path)[1].lower()
        if file_ext not in self.SUPPORTED_FORMATS:
            raise OpenAIException.unexpected_custom(
                f"GptWhisper1ReaderApiRepository: Unsupported format {file_ext}. "
                f"Supported: {', '.join(self.SUPPORTED_FORMATS)}"
            )

        # Open audio file and send to API
        with open(audio_file_path, "rb") as audio_file:
            # Build request parameters
            request_params = {
                "model": model,
                "file": audio_file,
                "response_format": response_format,
            }

            # Add optional language parameter
            if language:
                request_params["language"] = language

            # Call OpenAI Whisper API
            transcript = self._open_ai_client.audio.transcriptions.create(**request_params)

            # Handle different response formats
            if response_format == "text":
                return str(transcript)
            else:
                # For json/verbose_json/srt/vtt, return as-is
                return transcript

