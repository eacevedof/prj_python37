"""Servicio para generar audio de pronunciación con IA (con acento del idioma)."""

import asyncio
from pathlib import Path
from typing import final, Self

from ddd.shared.infrastructure.components.logger import Logger
from ddd.open_ai.domain.enums import (
    OpenaiTtsConstraintsEnum,
    OpenaiTtsFormatEnum,
    OpenaiTtsModelEnum,
)
from ddd.open_ai.infrastructure.repositories import GptTts1ReaderApiRepository
from ddd.vocabulary.application.generate_word_audio_ai.generate_word_audio_ai_dto import (
    GenerateWordAudioAiDto,
)
from ddd.vocabulary.application.generate_word_audio_ai.generate_word_audio_ai_result_dto import (
    GenerateWordAudioAiResultDto,
)
from ddd.vocabulary.domain.entities import WordLangEntity
from ddd.vocabulary.domain.enums import TtsAccentEnum
from ddd.vocabulary.domain.services import TtsVoiceSelectorService
from ddd.vocabulary.infrastructure.repositories import (
    WordsLangReaderSqliteRepository,
    WordsLangWriterSqliteRepository,
)


@final
class GenerateWordAudioAiService:
    """Servicio para generar audio con el acento del idioma (gpt-4o-mini-tts / tts-1)."""

    _instance: "GenerateWordAudioAiService | None" = None

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._gpt_tts_1_reader_api_repository = (
            GptTts1ReaderApiRepository.get_instance()
        )
        self._words_lang_reader_sqlite_repository = (
            WordsLangReaderSqliteRepository.get_instance()
        )
        self._words_lang_writer_sqlite_repository = (
            WordsLangWriterSqliteRepository.get_instance()
        )

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def __call__(
        self, generate_word_audio_ai_dto: GenerateWordAudioAiDto
    ) -> GenerateWordAudioAiResultDto:
        """
        Genera audio de pronunciación para una traducción usando tts-1.

        Args:
            generate_word_audio_ai_dto: DTO con word_lang_id y opciones de voz.

        Returns:
            GenerateWordAudioAiResultDto con el resultado.
        """
        if not generate_word_audio_ai_dto.word_lang_id:
            return GenerateWordAudioAiResultDto.error("Se requiere word_lang_id")

        # Obtener traducción de la BD
        word_lang_dict = await self._words_lang_reader_sqlite_repository.get_by_id(
            generate_word_audio_ai_dto.word_lang_id
        )

        if not word_lang_dict:
            return GenerateWordAudioAiResultDto.error(
                f"No se encontró traducción con ID {generate_word_audio_ai_dto.word_lang_id}"
            )

        # Usar texto del DTO o del diccionario
        text_to_generate = generate_word_audio_ai_dto.text or word_lang_dict["text"]
        lang_code = generate_word_audio_ai_dto.lang_code or word_lang_dict["lang_code"]

        if not text_to_generate:
            return GenerateWordAudioAiResultDto.error("No hay texto para generar audio")

        # Verificar si ya existe el audio
        # Ruta absoluta a data/audio (independiente del CWD): parents[4] = raíz del proyecto
        audio_dir = Path(__file__).resolve().parents[4] / "data" / "audio"
        audio_filename = f"{word_lang_dict['id']}_{lang_code}.mp3"
        audio_path = audio_dir / audio_filename

        if audio_path.exists() and word_lang_dict.get("audio_path"):
            self._logger.log_info(
                "GenerateWordAudioAiService", f"Audio ya existe: {audio_path}"
            )
            return GenerateWordAudioAiResultDto.ok(
                word_lang_id=word_lang_dict["id"],
                audio_path=str(audio_path),
                voice_used="cached",
                model_used="cached",
                text_generated=text_to_generate,
            )

        # Seleccionar voz (lógica de dominio) y generar audio con el mismo camino
        # que "regenerar": acento del idioma -> gpt-4o-mini-tts; sin acento -> tts-1
        voice_used = (
            generate_word_audio_ai_dto.voice
            or TtsVoiceSelectorService.select(lang_code)
        )

        speed = generate_word_audio_ai_dto.speed
        if (
            not OpenaiTtsConstraintsEnum.MIN_SPEED.value
            <= speed
            <= OpenaiTtsConstraintsEnum.MAX_SPEED.value
        ):
            speed = 1.0

        accent = TtsAccentEnum.for_lang(lang_code)
        instructions = accent.instructions if accent else ""
        if instructions:
            model_used = OpenaiTtsModelEnum.GPT_4O_MINI_TTS.value
        else:
            model_used = OpenaiTtsModelEnum.TTS_1.value

        # En thread: la llamada a la API es sincrónica y bloquearía el event loop
        audio_bytes = await asyncio.to_thread(
            self._gpt_tts_1_reader_api_repository.get_audio_bytes_from_text,
            model=model_used,
            voice=voice_used,
            input_text=text_to_generate.strip(),
            speed=speed,
            response_format=OpenaiTtsFormatEnum.MP3,
            instructions=instructions,
        )

        # Guardar archivo MP3 en disco
        audio_dir.mkdir(parents=True, exist_ok=True)
        audio_path.write_bytes(audio_bytes)

        # Actualizar audio_path en BD - convertir dict a entity
        word_lang_entity = WordLangEntity.from_primitives(word_lang_dict)
        word_lang_entity.audio_path = str(audio_path)
        await self._words_lang_writer_sqlite_repository.update(word_lang_entity)

        self._logger.log_info(
            "GenerateWordAudioAiService",
            f"Audio generado: {audio_path} con voz '{voice_used}'",
        )

        return GenerateWordAudioAiResultDto.ok(
            word_lang_id=word_lang_dict["id"],
            audio_path=str(audio_path),
            voice_used=voice_used,
            model_used=model_used,
            text_generated=text_to_generate,
        )
