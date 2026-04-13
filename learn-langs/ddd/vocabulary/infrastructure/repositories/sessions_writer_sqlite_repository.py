import json
from datetime import datetime
from typing import final, Self

from ddd.shared.infrastructure.repositories.sqlite_connection import SqliteConnection
from ddd.vocabulary.domain.entities import StudySessionEntity


@final
class SessionsWriterSqliteRepository:
    """Repositorio de escritura para sesiones de estudio."""

    _sqlite: SqliteConnection

    def __init__(self) -> None:
        self._sqlite = SqliteConnection.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def create(self, study_session_entity: StudySessionEntity) -> int:
        """Crea una nueva sesión de estudio y retorna el ID generado."""
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        tags_json = json.dumps(study_session_entity.tags_filter) if study_session_entity.tags_filter else None

        query = """
            INSERT INTO study_sessions
            (lang_code, study_mode, started_at, tags_filter)
            VALUES (?, ?, ?, ?)
        """
        session_id = await self._sqlite.insert(
            query,
            (
                study_session_entity.lang_code,
                study_session_entity.study_mode.value,
                now,
                tags_json,
            ),
        )

        return session_id

    async def update(self, study_session_entity: StudySessionEntity) -> bool:
        """Actualiza una sesión existente."""
        tags_json = json.dumps(study_session_entity.tags_filter) if study_session_entity.tags_filter else None

        query = """
            UPDATE study_sessions
            SET total_words = ?,
                total_score = ?,
                average_score = ?,
                finished_at = ?,
                tags_filter = ?
            WHERE id = ?
        """
        rows = await self._sqlite.update(
            query,
            (
                study_session_entity.total_words,
                study_session_entity.total_score,
                study_session_entity.average_score,
                study_session_entity.finished_at if study_session_entity.finished_at else None,
                tags_json,
                study_session_entity.id,
            ),
        )
        return rows > 0

    async def finish(self, study_session_entity: StudySessionEntity) -> bool:
        """Finaliza una sesión de estudio."""
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        query = """
            UPDATE study_sessions
            SET finished_at = ?
            WHERE id = ? AND finished_at IS NULL
        """
        rows = await self._sqlite.update(query, (now, study_session_entity.id))
        return rows > 0

    async def delete(self, study_session_entity: StudySessionEntity) -> bool:
        """Elimina una sesión (y sus respuestas por CASCADE)."""
        query = "DELETE FROM study_sessions WHERE id = ?"
        rows = await self._sqlite.delete(query, (study_session_entity.id,))
        return rows > 0
