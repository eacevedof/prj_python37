"""Servicio para regenerar el audio de una palabra+idioma (propuesta temporal)."""

from typing import final, Self

from ddd.shared.infrastructure.components.logger import Logger
from ddd.open_ai.domain.enums import (
    OpenaiTtsConstraintsEnum,
    OpenaiTtsFormatEnum,
    OpenaiTtsModelEnum,
)
from ddd.open_ai.infrastructure.repositories import GptTts1ReaderApiRepository
from ddd.vocabulary.application.regenerate_word_audio.regenerate_word_audio_dto import (
    RegenerateWordAudioDto,
)
from ddd.vocabulary.application.regenerate_word_audio.regenerate_word_audio_result_dto import (
    RegenerateWordAudioResultDto,
)
from ddd.vocabulary.domain.enums import TtsAccentEnum
from ddd.vocabulary.domain.services import TtsVoiceSelectorService
from ddd.vocabulary.infrastructure.repositories import WordAudiosWriterFileRepository


@final
class RegenerateWordAudioService:
    """Regenera el audio de una palabra+idioma.

    Genera un mp3 nuevo con el acento activo del idioma (TtsAccentEnum;
    p.ej. Haarlem por defecto en nl_NL), borra el definitivo existente y
    guarda el nuevo como propuesta TEMPORAL (word-<id>-<accent>-temp.mp3).
    El usuario la comprueba y decide: aceptar (pasa a definitivo, ver
    AcceptWordAudioService) o descartar (DiscardWordAudioService).
    """

    _instance: "RegenerateWordAudioService | None" = None

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._gpt_tts_1_reader_api_repository = GptTts1ReaderApiRepository.get_instance()
        self._word_audios_writer_file_repository = WordAudiosWriterFileRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def __call__(
        self,
        regenerate_word_audio_dto: RegenerateWordAudioDto
    ) -> RegenerateWordAudioResultDto:
        """
        Regenera el audio y devuelve la ruta de la propuesta temporal.

        Args:
            regenerate_word_audio_dto: DTO con word_id, lang_code y texto a pronunciar.

        Returns:
            RegenerateWordAudioResultDto con la ruta temporal o el error.
        """
        text_to_generate = regenerate_word_audio_dto.text
        lang_code = regenerate_word_audio_dto.lang_code
        word_id = regenerate_word_audio_dto.word_id

        if word_id <= 0:
            return RegenerateWordAudioResultDto.error("Se requiere word_id")

        if not lang_code:
            return RegenerateWordAudioResultDto.error("Se requiere lang_code")

        if not text_to_generate:
            return RegenerateWordAudioResultDto.error("No hay texto para generar audio")

        try:
            voice_used = regenerate_word_audio_dto.voice or TtsVoiceSelectorService.select(lang_code)

            speed = regenerate_word_audio_dto.speed
            if not OpenaiTtsConstraintsEnum.MIN_SPEED.value <= speed <= OpenaiTtsConstraintsEnum.MAX_SPEED.value:
                speed = 1.0

            # Acento por idioma: con instrucción -> gpt-4o-mini-tts; si no -> tts-1
            accent = TtsAccentEnum.for_lang(lang_code)
            instructions = accent.instructions if accent else ""
            if instructions:
                model_used = OpenaiTtsModelEnum.GPT_4O_MINI_TTS.value
            else:
                model_used = OpenaiTtsModelEnum.TTS_1.value

            audio_bytes = self._gpt_tts_1_reader_api_repository.get_audio_bytes_from_text(
                model=model_used,
                voice=voice_used,
                input_text=text_to_generate,
                speed=speed,
                response_format=OpenaiTtsFormatEnum.MP3,
                instructions=instructions,
            )

            # Solo tras generar con éxito: borrar el definitivo y guardar la propuesta
            self._word_audios_writer_file_repository.delete_audio(word_id, lang_code)
            temp_audio_path = self._word_audios_writer_file_repository.save_temp_audio(
                word_id, lang_code, audio_bytes
            )

            self._logger.log_info(
                "RegenerateWordAudioService",
                f"Audio regenerado (temporal): {temp_audio_path} con voz '{voice_used}'"
            )

            return RegenerateWordAudioResultDto.ok(
                temp_audio_path=temp_audio_path,
                voice_used=voice_used,
                model_used=model_used,
            )

        except Exception as e:
            error_msg = f"Error al regenerar audio: {str(e)}"
            self._logger.log_error("RegenerateWordAudioService", error_msg)
            return RegenerateWordAudioResultDto.error(error_msg)
