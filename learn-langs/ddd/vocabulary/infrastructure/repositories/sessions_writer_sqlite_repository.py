"""Repositorio de escritura para sesiones de estudio."""

import json
from datetime import datetime
from typing import final, Self

from ddd.shared.infrastructure.repositories import AbstractSqliteRepository
from ddd.vocabulary.domain.entities import StudySessionEntity


@final
class SessionsWriterSqliteRepository(AbstractSqliteRepository):
    """Repositorio de escritura para sesiones de estudio."""

    def __init__(self) -> None:
        super().__init__()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def create(self, study_session_entity: StudySessionEntity) -> int:
        """Crea una nueva sesión de estudio y retorna el ID generado."""
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        tags_json = json.dumps(study_session_entity.tags_filter) if study_session_entity.tags_filter else None

        return await self._insert_into("study_sessions", {
            "lang_code": study_session_entity.lang_code,
            "study_mode": study_session_entity.study_mode.value,
            "started_at": now,
            "tags_filter": tags_json,
        })

    async def update(self, study_session_entity: StudySessionEntity) -> bool:
        """Actualiza una sesión existente."""
        tags_json = json.dumps(study_session_entity.tags_filter) if study_session_entity.tags_filter else None

        rows = await self._update_where(
            "study_sessions",
            {
                "total_words": study_session_entity.total_words,
                "total_score": study_session_entity.total_score,
                "average_score": study_session_entity.average_score,
                "finished_at": study_session_entity.finished_at if study_session_entity.finished_at else None,
                "tags_filter": tags_json,
            },
            "id = ?",
            (study_session_entity.id,),
        )
        return rows > 0

    async def finish(self, study_session_entity: StudySessionEntity) -> bool:
        """Finaliza una sesión de estudio."""
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        rows = await self._sqlite.update(
            """
            UPDATE study_sessions
            SET finished_at = ?
            WHERE id = ? AND finished_at IS NULL
            """,
            (now, study_session_entity.id),
        )
        return rows > 0

    async def delete(self, study_session_entity: StudySessionEntity) -> bool:
        """Elimina una sesión (y sus respuestas por CASCADE)."""
        rows = await self._delete_where("study_sessions", "id = ?", (study_session_entity.id,))
        return rows > 0
