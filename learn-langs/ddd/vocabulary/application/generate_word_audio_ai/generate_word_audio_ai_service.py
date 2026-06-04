"""Servicio para generar audio de pronunciación con IA (tts-1)."""

import base64
from pathlib import Path
from typing import final, Self

from ddd.shared.infrastructure.components.logger import Logger
from ddd.open_ai.infrastructure.repositories import GptTts1ReaderApiRepository
from ddd.vocabulary.application.generate_word_audio_ai.generate_word_audio_ai_dto import (
    GenerateWordAudioAiDto,
)
from ddd.vocabulary.application.generate_word_audio_ai.generate_word_audio_ai_result_dto import (
    GenerateWordAudioAiResultDto,
)
from ddd.vocabulary.domain.entities import WordLangEntity
from ddd.vocabulary.infrastructure.repositories import (
    WordsLangReaderSqliteRepository,
    WordsLangWriterSqliteRepository,
)


@final
class GenerateWordAudioAiService:
    """Servicio para generar audio con tts-1."""

    _instance: "GenerateWordAudioAiService | None" = None

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._gpt_tts_1_reader_api_repository = GptTts1ReaderApiRepository.get_instance()
        self._words_lang_reader_sqlite_repository = WordsLangReaderSqliteRepository.get_instance()
        self._words_lang_writer_sqlite_repository = WordsLangWriterSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def __call__(
        self,
        generate_word_audio_ai_dto: GenerateWordAudioAiDto
    ) -> GenerateWordAudioAiResultDto:
        """
        Genera audio de pronunciación para una traducción usando tts-1.

        Args:
            generate_word_audio_ai_dto: DTO con word_lang_id y opciones de voz.

        Returns:
            GenerateWordAudioAiResultDto con el resultado.
        """
        if not generate_word_audio_ai_dto.word_lang_id:
            return GenerateWordAudioAiResultDto.error(
                "Se requiere word_lang_id"
            )

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
            return GenerateWordAudioAiResultDto.error(
                "No hay texto para generar audio"
            )

        # Verificar si ya existe el audio
        audio_dir = Path("data/audio")
        audio_filename = f"{word_lang_dict['id']}_{lang_code}.mp3"
        audio_path = audio_dir / audio_filename

        if audio_path.exists() and word_lang_dict.get("audio_path"):
            self._logger.log_info(
                "GenerateWordAudioAiService",
                f"Audio ya existe: {audio_path}"
            )
            return GenerateWordAudioAiResultDto.ok(
                word_lang_id=word_lang_dict["id"],
                audio_path=str(audio_path),
                voice_used="cached",
                model_used="cached",
                text_generated=text_to_generate,
            )

        # Generar audio con tts-1
        try:
            tts_response = self._gpt_tts_1_reader_api_repository.get_audio_pronunciation_by_text(
                text=text_to_generate,
                lang_code=lang_code,
                voice=generate_word_audio_ai_dto.voice,
                speed=generate_word_audio_ai_dto.speed,
            )

            audio_b64 = tts_response["audio_b64"]
            voice_used = tts_response["voice_used"]
            model_used = tts_response["model"]

            # Decodificar audio desde base64
            audio_bytes = base64.b64decode(audio_b64)

            # Guardar archivo MP3 en disco
            audio_dir.mkdir(parents=True, exist_ok=True)
            audio_path.write_bytes(audio_bytes)

            # Actualizar audio_path en BD - convertir dict a entity
            word_lang_entity = WordLangEntity.from_primitives(word_lang_dict)
            word_lang_entity.audio_path = str(audio_path)
            await self._words_lang_writer_sqlite_repository.update(word_lang_entity)

            self._logger.log_info(
                "GenerateWordAudioAiService",
                f"Audio generado: {audio_path} con voz '{voice_used}'"
            )

            return GenerateWordAudioAiResultDto.ok(
                word_lang_id=word_lang_dict["id"],
                audio_path=str(audio_path),
                voice_used=voice_used,
                model_used=model_used,
                text_generated=text_to_generate,
            )

        except Exception as e:
            error_msg = f"Error al generar audio: {str(e)}"
            self._logger.log_error("GenerateWordAudioAiService", error_msg)
            return GenerateWordAudioAiResultDto.error(error_msg)
