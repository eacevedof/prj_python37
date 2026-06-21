"""Servicio para generar audio de un texto arbitrario con IA (tts-1)."""

from pathlib import Path
from typing import final, Self

from ddd.shared.infrastructure.components.logger import Logger
from ddd.open_ai.domain.enums import (
    OpenaiTtsConstraintsEnum,
    OpenaiTtsFormatEnum,
    OpenaiTtsModelEnum,
)
from ddd.open_ai.infrastructure.repositories import GptTts1ReaderApiRepository
from ddd.vocabulary.application.generate_text_audio_ai.generate_text_audio_ai_dto import (
    GenerateTextAudioAiDto,
)
from ddd.vocabulary.application.generate_text_audio_ai.generate_text_audio_ai_result_dto import (
    GenerateTextAudioAiResultDto,
)
from ddd.vocabulary.domain.services import TtsVoiceSelectorService


@final
class GenerateTextAudioAiService:
    """Servicio para generar audio de un texto arbitrario con tts-1.

    Genérico y desacoplado de words_lang: cachea el mp3 en data/audio
    usando cache_key. Lo usa el slider para pronunciar tanto el origen
    español como la traducción del idioma destino.
    """

    _instance: "GenerateTextAudioAiService | None" = None

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._gpt_tts_1_reader_api_repository = GptTts1ReaderApiRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def __call__(
        self,
        generate_text_audio_ai_dto: GenerateTextAudioAiDto
    ) -> GenerateTextAudioAiResultDto:
        """
        Genera (o reutiliza de cache) el audio de un texto con tts-1.

        Args:
            generate_text_audio_ai_dto: DTO con texto, idioma y clave de cache.

        Returns:
            GenerateTextAudioAiResultDto con la ruta del audio o el error.
        """
        text_to_generate = generate_text_audio_ai_dto.text
        lang_code = generate_text_audio_ai_dto.lang_code
        cache_key = generate_text_audio_ai_dto.cache_key

        if not text_to_generate:
            return GenerateTextAudioAiResultDto.error("No hay texto para generar audio")

        if not cache_key:
            return GenerateTextAudioAiResultDto.error("Se requiere cache_key")

        # Reutilizar audio cacheado si existe
        audio_dir = Path("data/audio")
        audio_path = audio_dir / f"{cache_key}.mp3"

        if audio_path.exists():
            return GenerateTextAudioAiResultDto.ok(
                audio_path=str(audio_path),
                voice_used="cached",
                model_used="cached",
                text_generated=text_to_generate,
            )

        # Seleccionar voz (lógica de dominio) y generar audio con tts-1
        try:
            voice_used = generate_text_audio_ai_dto.voice or TtsVoiceSelectorService.select(lang_code)
            model_used = OpenaiTtsModelEnum.TTS_1.value

            speed = generate_text_audio_ai_dto.speed
            if not OpenaiTtsConstraintsEnum.MIN_SPEED.value <= speed <= OpenaiTtsConstraintsEnum.MAX_SPEED.value:
                speed = 1.0

            audio_bytes = self._gpt_tts_1_reader_api_repository.get_audio_bytes_from_text(
                model=model_used,
                voice=voice_used,
                input_text=text_to_generate,
                speed=speed,
                response_format=OpenaiTtsFormatEnum.MP3,
            )

            audio_dir.mkdir(parents=True, exist_ok=True)
            audio_path.write_bytes(audio_bytes)

            self._logger.log_info(
                "GenerateTextAudioAiService",
                f"Audio generado: {audio_path} con voz '{voice_used}'"
            )

            return GenerateTextAudioAiResultDto.ok(
                audio_path=str(audio_path),
                voice_used=voice_used,
                model_used=model_used,
                text_generated=text_to_generate,
            )

        except Exception as e:
            error_msg = f"Error al generar audio: {str(e)}"
            self._logger.log_error("GenerateTextAudioAiService", error_msg)
            return GenerateTextAudioAiResultDto.error(error_msg)
