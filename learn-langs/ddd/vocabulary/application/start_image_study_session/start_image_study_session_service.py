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
    _metrics_reader: MetricsReaderSqliteRepository
    _sessions_writer: SessionsWriterSqliteRepository

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: StartImageStudySessionDto) -> StartImageStudySessionResultDto:
        """
        Inicia una nueva sesión de estudio con imágenes.

        Args:
            dto: Configuración de la sesión.

        Returns:
            StartImageStudySessionResultDto con la sesión y palabras con imágenes.

        Raises:
            VocabularyException: Si no hay palabras con imágenes disponibles.
        """
        self._start_image_study_session_dto = dto
        self._metrics_reader = MetricsReaderSqliteRepository.get_instance()
        self._sessions_writer = SessionsWriterSqliteRepository.get_instance()

        # Validar
        errors = dto.validate()
        if errors:
            raise VocabularyException.word_creation_failed(", ".join(errors))

        # Obtener palabras con imágenes para repaso (SM-2 + filtro de imágenes)
        words_data = await self._metrics_reader.get_words_with_images_for_review(
            lang_code=dto.lang_code,
            tag_names=dto.tags if dto.tags else None,
            limit=dto.limit,
        )

        if not words_data:
            raise VocabularyException.no_words_for_image_study(dto.lang_code)

        # Crear entidad de sesión
        study_session_entity = StudySessionEntity.from_primitives({
            "id": 0,
            "lang_code": dto.lang_code,
            "study_mode": StudyModeEnum.IMAGE_TYPING.value,
            "tags_filter": dto.tags if dto.tags else [],
        })

        # Crear sesión
        session_id = await self._sessions_writer.create(study_session_entity)

        # Construir resultado
        return StartImageStudySessionResultDto.from_primitives({
            "session_id": session_id,
            "lang_code": dto.lang_code,
            "study_mode": StudyModeEnum.IMAGE_TYPING.value,
            "started_at": "",
            "words": words_data,
            "tags_filter": dto.tags,
        })
