"""Servicio para descartar (borrar) una sesión de estudio al abortar."""

from typing import final, Self

from ddd.vocabulary.application.discard_study_session.discard_study_session_dto import (
    DiscardStudySessionDto,
)
from ddd.vocabulary.application.discard_study_session.discard_study_session_result_dto import (
    DiscardStudySessionResultDto,
)
from ddd.vocabulary.domain.entities import StudySessionEntity
from ddd.vocabulary.infrastructure.repositories import SessionsWriterSqliteRepository


@final
class DiscardStudySessionService:
    """Borra una sesión de estudio (y sus respuestas por CASCADE).

    Lo usa el examen al ABORTAR: la sesión se creó vacía y, como las respuestas
    se acumulan en memoria (no se persisten hasta completar), borrarla deja la
    BD como si el examen no hubiera ocurrido.
    """

    _instance: "DiscardStudySessionService | None" = None

    def __init__(self) -> None:
        self._sessions_writer_sqlite_repository = (
            SessionsWriterSqliteRepository.get_instance()
        )

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def __call__(
        self, discard_study_session_dto: DiscardStudySessionDto
    ) -> DiscardStudySessionResultDto:
        session_id = discard_study_session_dto.session_id
        if not session_id:
            return DiscardStudySessionResultDto.from_primitives({"is_discarded": False})

        is_discarded = await self._sessions_writer_sqlite_repository.delete(
            StudySessionEntity.from_primitives({"id": session_id})
        )
        return DiscardStudySessionResultDto.from_primitives({
            "session_id": session_id,
            "is_discarded": is_discarded,
        })
