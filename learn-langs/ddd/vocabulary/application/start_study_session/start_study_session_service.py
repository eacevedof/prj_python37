from typing import final, Self

from ddd.vocabulary.application.start_study_session.start_study_session_dto import StartStudySessionDto
from ddd.vocabulary.application.start_study_session.start_study_session_result_dto import (
    StartStudySessionResultDto,
    StudyWordDto,
)
from ddd.vocabulary.domain.exceptions import VocabularyException
from ddd.vocabulary.infrastructure.repositories import (
    MetricsReaderSqliteRepository,
    SessionsWriterSqliteRepository,
)


@final
class StartStudySessionService:
    """Servicio para iniciar una sesión de estudio."""

    _start_study_session_dto: StartStudySessionDto
    _metrics_reader: MetricsReaderSqliteRepository
    _sessions_writer: SessionsWriterSqliteRepository

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, start_study_session_dto: StartStudySessionDto) -> StartStudySessionResultDto:
        """
        Inicia una nueva sesión de estudio.

        Args:
            start_study_session_dto: Configuración de la sesión.

        Returns:
            StartStudySessionResultDto con la sesión y palabras a estudiar.

        Raises:
            VocabularyException: Si no hay palabras disponibles.
        """
        self._start_study_session_dto = start_study_session_dto
        self._metrics_reader = MetricsReaderSqliteRepository.get_instance()
        self._sessions_writer = SessionsWriterSqliteRepository.get_instance()

        # Validar
        errors = start_study_session_dto.validate()
        if errors:
            raise VocabularyException.word_creation_failed(", ".join(errors))

        # Obtener palabras para repaso (SM-2)
        words_data = await self._metrics_reader.get_words_for_review(
            lang_code=start_study_session_dto.lang_code,
            tag_names=start_study_session_dto.tags if start_study_session_dto.tags else None,
            limit=start_study_session_dto.limit,
        )

        if not words_data:
            raise VocabularyException.no_words_for_study(start_study_session_dto.lang_code)

        # Crear sesión
        session_data = await self._sessions_writer.create(
            lang_code=start_study_session_dto.lang_code,
            study_mode=start_study_session_dto.study_mode,
            tags_filter=start_study_session_dto.tags if start_study_session_dto.tags else None,
        )

        # Construir resultado
        words = [StudyWordDto.from_primitives(w) for w in words_data]

        return StartStudySessionResultDto(
            session_id=session_data["id"],
            lang_code=session_data["lang_code"],
            study_mode=session_data["study_mode"],
            started_at=session_data["started_at"],
            total_words=len(words),
            words=words,
            tags_filter=dto.tags,
        )
