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
from ddd.vocabulary.domain.enums import StudyModeEnum
from ddd.vocabulary.infrastructure.repositories import SessionsWriterSqliteRepository


@final
class FinishStudySessionService:
    """Servicio para finalizar sesiones de estudio."""

    _instance: "FinishStudySessionService | None" = None

    def __init__(self) -> None:
        self._sessions_writer = SessionsWriterSqliteRepository.get_instance()
        self._logger = Logger.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def __call__(self, dto: FinishStudySessionDto) -> FinishStudySessionResultDto:
        """
        Finaliza una sesion de estudio.

        Args:
            dto: DTO con datos de la sesion.

        Returns:
            FinishStudySessionResultDto con el resultado.
        """
        if not dto.session_id:
            return FinishStudySessionResultDto.ok(0)

        try:
            entity = StudySessionEntity.from_primitives({
                "id": dto.session_id,
                "lang_code": dto.lang_code,
                "study_mode": dto.study_mode,
            })

            await self._sessions_writer.finish(entity)

            return FinishStudySessionResultDto.ok(dto.session_id)

        except Exception as e:
            self._logger.write_error(
                "FinishStudySessionService",
                f"Error finalizando sesion: {e}",
                {"session_id": dto.session_id},
            )
            return FinishStudySessionResultDto.error(str(e))
