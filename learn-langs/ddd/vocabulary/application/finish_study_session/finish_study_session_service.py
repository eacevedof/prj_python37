"""Servicio para finalizar sesion de estudio."""

from typing import final, Self

from ddd.shared.infrastructure.components.logger import Logger
from ddd.vocabulary.application.finish_study_session.finish_study_session_dto import (
    FinishStudySessionDto,
)
from ddd.vocabulary.application.finish_study_session.finish_study_session_result_dto import (
    FinishStudySessionResultDto,
)
from ddd.vocabulary.domain.entities import StudySessionEntity
from ddd.vocabulary.infrastructure.repositories import SessionsWriterSqliteRepository

@final
class FinishStudySessionService:
    """Servicio para finalizar sesiones de estudio."""

    _instance: "FinishStudySessionService | None" = None

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._sessions_writer_sqlite_repository_sqlite_repository = SessionsWriterSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance


    async def __call__(
        self,
        finish_study_session_dto: FinishStudySessionDto
    ) -> FinishStudySessionResultDto:
        """
        Finaliza una sesion de estudio.

        Args:
            finish_study_session_dto: DTO con datos de la sesion.

        Returns:
            FinishStudySessionResultDto con el resultado.
        """
        if not finish_study_session_dto.session_id:
            return FinishStudySessionResultDto.ok(0)


        await self._sessions_writer_sqlite_repository_sqlite_repository.finish_study_session_by_session_id(
            StudySessionEntity.from_primitives({
                "id": finish_study_session_dto.session_id,
                "lang_code": finish_study_session_dto.lang_code,
                "study_mode": finish_study_session_dto.study_mode,
            })
        )

        return FinishStudySessionResultDto.ok(finish_study_session_dto.session_id)
