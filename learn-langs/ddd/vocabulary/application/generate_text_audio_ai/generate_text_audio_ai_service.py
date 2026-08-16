"""Servicio para generar audio de un texto arbitrario con IA (tts-1)."""

import asyncio
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
from ddd.vocabulary.domain.enums import AudioSourceEnum, TtsAccentEnum
from ddd.vocabulary.domain.services import TtsVoiceSelectorService
from ddd.vocabulary.infrastructure.repositories.word_audios_reader_file_repository import (
    WordAudiosReaderFileRepository,
)
from ddd.vocabulary.infrastructure.repositories.word_audios_writer_file_repository import (
    WordAudiosWriterFileRepository,
)


@final
class GenerateTextAudioAiService:
    """Servicio para generar audio de un texto arbitrario con tts-1.

    Genérico y desacoplado de words_lang: cachea el mp3 en data/audio
    usando cache_key. Lo usa el slider para pronunciar tanto el origen
    español como la traducción del idioma destino.
    """

    # Los acentos disponibles están enumerados en TtsAccentEnum (idioma + etiqueta
    # de fichero + instrucción). Si un idioma tiene acento -> gpt-4o-mini-tts;
    # si no -> tts-1 (sin control de acento).

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._gpt_tts_1_reader_api_repository = GptTts1ReaderApiRepository.get_instance()
        self._word_audios_reader_file_repository = WordAudiosReaderFileRepository.get_instance()
        self._word_audios_writer_file_repository = WordAudiosWriterFileRepository.get_instance()
        self._tts_voice_selector_service = TtsVoiceSelectorService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

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
        word_id = generate_text_audio_ai_dto.word_id

        if not text_to_generate:
            return GenerateTextAudioAiResultDto.error("No hay texto para generar audio")

        if word_id <= 0:
            return GenerateTextAudioAiResultDto.error("Se requiere word_id")

        # Reutilizar audio cacheado si existe (nombre con id + idioma + acento);
        # la ruta y el nombre los resuelve el repositorio de ficheros.
        if self._word_audios_reader_file_repository.has_audio(word_id, lang_code):
            return GenerateTextAudioAiResultDto.ok(
                audio_path=self._word_audios_reader_file_repository.get_audio_path(
                    word_id, lang_code
                ),
                voice_used=AudioSourceEnum.CACHED.value,
                model_used=AudioSourceEnum.CACHED.value,
                text_generated=text_to_generate,
            )

        # Seleccionar voz (lógica de dominio) y generar audio con tts-1
        voice_used = generate_text_audio_ai_dto.voice or self._tts_voice_selector_service.get_voice(
            lang_code
        )

        speed = generate_text_audio_ai_dto.speed
        if not OpenaiTtsConstraintsEnum.MIN_SPEED.value <= speed <= OpenaiTtsConstraintsEnum.MAX_SPEED.value:
            speed = 1.0

        # Acento por idioma: con instrucción -> gpt-4o-mini-tts; si no -> tts-1
        accent = TtsAccentEnum.for_lang(lang_code)
        model_used = OpenaiTtsModelEnum.TTS_1.value
        instructions = accent.instructions if accent else ""
        if instructions:
            model_used = OpenaiTtsModelEnum.GPT_4O_MINI_TTS.value

        # En thread: la llamada a la API es sincrónica y bloquearía el event
        # loop de la UI (clics de pausa/navegación sin respuesta)
        audio_bytes = await asyncio.to_thread(
            self._gpt_tts_1_reader_api_repository.get_audio_bytes_from_text,
            model=model_used,
            voice=voice_used,
            input_text=text_to_generate,
            speed=speed,
            response_format=OpenaiTtsFormatEnum.MP3,
            instructions=instructions,
        )

        audio_path = self._word_audios_writer_file_repository.save_audio(
            word_id, lang_code, audio_bytes
        )

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
