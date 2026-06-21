"""Servicio para iniciar sesión de slider (presentación auto-reproducida)."""

from typing import final, Self

from ddd.vocabulary.application.start_word_slider_session.start_word_slider_session_dto import (
    StartWordSliderSessionDto,
)
from ddd.vocabulary.application.start_word_slider_session.start_word_slider_session_result_dto import (
    StartWordSliderSessionResultDto,
)
from ddd.vocabulary.domain.entities import StudySessionEntity
from ddd.vocabulary.domain.enums import StudyModeEnum
from ddd.vocabulary.domain.exceptions import VocabularyException
from ddd.vocabulary.infrastructure.repositories import (
    MetricsReaderSqliteRepository,
    SessionsWriterSqliteRepository,
)


@final
class StartWordSliderSessionService:
    """Servicio para iniciar una sesión de slider."""

    _start_word_slider_session_dto: StartWordSliderSessionDto
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
        start_word_slider_session_dto: StartWordSliderSessionDto
    ) -> StartWordSliderSessionResultDto:
        """
        Inicia una nueva sesión de slider.

        Args:
            start_word_slider_session_dto: Configuración de la sesión.

        Returns:
            StartWordSliderSessionResultDto con la sesión y palabras a presentar.

        Raises:
            VocabularyException: Si no hay palabras disponibles.
        """
        self._start_word_slider_session_dto = start_word_slider_session_dto

        # Validar
        errors = start_word_slider_session_dto.validate()
        if errors:
            VocabularyException.word_creation_failed(", ".join(errors))

        # Obtener palabras para repaso (SM-2): prioriza palabras/frases complicadas.
        # Incluye imagen principal (opcional) para mostrarla en el slider.
        words_data = await self._metrics_reader_sqlite_repository.get_words_for_slider(
            lang_code=start_word_slider_session_dto.lang_code,
            tag_names=start_word_slider_session_dto.tags if start_word_slider_session_dto.tags else None,
            group_id=start_word_slider_session_dto.group_id,
            limit=start_word_slider_session_dto.limit,
        )

        if not words_data:
            VocabularyException.no_words_for_slider(
                start_word_slider_session_dto.lang_code
            )

        # Crear sesión
        session_id = await self._sessions_writer_sqlite_repository.create_study_session(
            StudySessionEntity.from_primitives({
                "id": 0,
                "lang_code": start_word_slider_session_dto.lang_code,
                "study_mode": StudyModeEnum.SLIDER.value,
                "tags_filter": start_word_slider_session_dto.tags if start_word_slider_session_dto.tags else [],
            })
        )

        # Construir resultado
        return StartWordSliderSessionResultDto.from_primitives({
            "session_id": session_id,
            "lang_code": start_word_slider_session_dto.lang_code,
            "study_mode": StudyModeEnum.SLIDER.value,
            "started_at": "",
            "words": words_data,
            "tags_filter": start_word_slider_session_dto.tags,
        })
