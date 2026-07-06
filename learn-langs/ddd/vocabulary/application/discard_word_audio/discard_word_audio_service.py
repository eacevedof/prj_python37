"""Servicio para descartar la propuesta temporal de audio de una palabra+idioma."""

from typing import final, Self

from ddd.shared.infrastructure.components.logger import Logger
from ddd.vocabulary.application.discard_word_audio.discard_word_audio_dto import (
    DiscardWordAudioDto,
)
from ddd.vocabulary.application.discard_word_audio.discard_word_audio_result_dto import (
    DiscardWordAudioResultDto,
)
from ddd.vocabulary.infrastructure.repositories import WordAudiosWriterFileRepository


@final
class DiscardWordAudioService:
    """Descarta la propuesta temporal de audio (borra el mp3 -temp).

    El audio definitivo se regenerará automáticamente en la próxima
    reproducción (caché por nombre de fichero con el acento activo).
    """

    _instance: "DiscardWordAudioService | None" = None

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._word_audios_writer_file_repository = WordAudiosWriterFileRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def __call__(
        self,
        discard_word_audio_dto: DiscardWordAudioDto
    ) -> DiscardWordAudioResultDto:
        word_id = discard_word_audio_dto.word_id
        lang_code = discard_word_audio_dto.lang_code

        if word_id <= 0:
            return DiscardWordAudioResultDto.error("Se requiere word_id")

        if not lang_code:
            return DiscardWordAudioResultDto.error("Se requiere lang_code")

        try:
            self._word_audios_writer_file_repository.delete_temp_audio(word_id, lang_code)

            self._logger.log_info(
                "DiscardWordAudioService",
                f"Propuesta de audio descartada: palabra #{word_id} ({lang_code})"
            )

            return DiscardWordAudioResultDto.ok()

        except Exception as e:
            error_msg = f"Error al descartar audio: {str(e)}"
            self._logger.log_error("DiscardWordAudioService", error_msg)
            return DiscardWordAudioResultDto.error(error_msg)
