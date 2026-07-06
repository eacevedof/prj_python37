"""Servicio para aceptar la propuesta temporal de audio de una palabra+idioma."""

from typing import final, Self

from ddd.shared.infrastructure.components.logger import Logger
from ddd.vocabulary.application.accept_word_audio.accept_word_audio_dto import (
    AcceptWordAudioDto,
)
from ddd.vocabulary.application.accept_word_audio.accept_word_audio_result_dto import (
    AcceptWordAudioResultDto,
)
from ddd.vocabulary.infrastructure.repositories import (
    WordAudiosReaderFileRepository,
    WordAudiosWriterFileRepository,
)


@final
class AcceptWordAudioService:
    """Acepta la propuesta temporal: el mp3 -temp pasa a ser el definitivo (el ideal)."""

    _instance: "AcceptWordAudioService | None" = None

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._word_audios_reader_file_repository = WordAudiosReaderFileRepository.get_instance()
        self._word_audios_writer_file_repository = WordAudiosWriterFileRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def __call__(
        self,
        accept_word_audio_dto: AcceptWordAudioDto
    ) -> AcceptWordAudioResultDto:
        word_id = accept_word_audio_dto.word_id
        lang_code = accept_word_audio_dto.lang_code

        if word_id <= 0:
            return AcceptWordAudioResultDto.error("Se requiere word_id")

        if not lang_code:
            return AcceptWordAudioResultDto.error("Se requiere lang_code")

        if not self._word_audios_reader_file_repository.has_temp_audio(word_id, lang_code):
            return AcceptWordAudioResultDto.error(
                f"No hay audio temporal que aceptar para la palabra #{word_id} ({lang_code})"
            )

        try:
            audio_path = self._word_audios_writer_file_repository.promote_temp_audio(
                word_id, lang_code
            )

            self._logger.log_info(
                "AcceptWordAudioService",
                f"Audio aceptado como definitivo: {audio_path}"
            )

            return AcceptWordAudioResultDto.ok(audio_path=audio_path)

        except Exception as e:
            error_msg = f"Error al aceptar audio: {str(e)}"
            self._logger.log_error("AcceptWordAudioService", error_msg)
            return AcceptWordAudioResultDto.error(error_msg)
