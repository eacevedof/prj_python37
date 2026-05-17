"""Servicio para iniciar sesión de estudio con imágenes."""

from typing import final, Self

from ddd.vocabulary.application.start_image_study_session.start_image_study_session_dto import StartImageStudySessionDto
from ddd.vocabulary.application.start_image_study_session.start_image_study_session_result_dto import (
    StartImageStudySessionResultDto,
    ImageStudyWordDto,
)
from ddd.vocabulary.domain.entities import StudySessionEntity
from ddd.vocabulary.domain.enums import StudyModeEnum
from ddd.vocabulary.domain.exceptions import VocabularyException
from ddd.vocabulary.infrastructure.repositories import (
    MetricsReaderSqliteRepository,
    SessionsWriterSqliteRepository,
)


@final
class StartImageStudySessionService:
    """Servicio para iniciar una sesión de estudio con imágenes."""

    _start_image_study_session_dto: StartImageStudySessionDto
    _metrics_reader_sqlite_repository: MetricsReaderSqliteRepository
    _sessions_writer_sqlite_repository: SessionsWriterSqliteRepository

    def __init__(self) -> None:
        self._metrics_reader_sqlite_repository = MetricsReaderSqliteRepository.get_instance()
        self._sessions_writer_sqlite_repository = SessionsWriterSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self,
        start_image_study_session_dto: StartImageStudySessionDto
    ) -> StartImageStudySessionResultDto:
        """
        Inicia una nueva sesión de estudio con imágenes.

        Args:
            start_image_study_session_dto: Configuración de la sesión.

        Returns:
            StartImageStudySessionResultDto con la sesión y palabras con imágenes.

        Raises:
            VocabularyException: Si no hay palabras con imágenes disponibles.
        """
        self._start_image_study_session_dto = start_image_study_session_dto

        # Validar
        errors = start_image_study_session_dto.validate()
        if errors:
            VocabularyException.word_creation_failed(", ".join(errors))

        # Obtener palabras con imágenes para repaso (SM-2 + filtro de imágenes)
        words_data = await self._metrics_reader_sqlite_repository.get_words_with_images_for_review(
            lang_code=start_image_study_session_dto.lang_code,
            tag_names=start_image_study_session_dto.tags if start_image_study_session_dto.tags else None,
            group_id=start_image_study_session_dto.group_id,
            limit=start_image_study_session_dto.limit,
        )

        if not words_data:
            VocabularyException.no_words_for_image_study(
                start_image_study_session_dto.lang_code
            )

        # Crear sesión
        session_id = await self._sessions_writer_sqlite_repository.create_study_session(
            StudySessionEntity.from_primitives({
                "id": 0,
                "lang_code": start_image_study_session_dto.lang_code,
                "study_mode": StudyModeEnum.IMAGE_TYPING.value,
                "tags_filter": start_image_study_session_dto.tags if start_image_study_session_dto.tags else [],
            })
        )

        # Construir resultado
        return StartImageStudySessionResultDto.from_primitives({
            "session_id": session_id,
            "lang_code": start_image_study_session_dto.lang_code,
            "study_mode": StudyModeEnum.IMAGE_TYPING.value,
            "started_at": "",
            "words": words_data,
            "tags_filter": start_image_study_session_dto.tags,
        })
