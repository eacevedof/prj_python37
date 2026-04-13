import json
from datetime import datetime
from typing import final, Self

from ddd.shared.infrastructure.repositories.sqlite_connection import SqliteConnection


@final
class SessionsWriterSqliteRepository:
    """Repositorio de escritura para sesiones de estudio."""

    _sqlite: SqliteConnection

    def __init__(self) -> None:
        self._sqlite = SqliteConnection.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def create(
        self,
        lang_code: str,
        study_mode: str,
        tags_filter: list[str] | None = None,
    ) -> dict:
        """Crea una nueva sesión de estudio."""
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        tags_json = json.dumps(tags_filter) if tags_filter else None

        query = """
            INSERT INTO study_sessions
            (lang_code, study_mode, started_at, tags_filter)
            VALUES (?, ?, ?, ?)
        """
        session_id = await self._sqlite.insert(
            query,
            (lang_code, study_mode, now, tags_json)
        )

        return {
            "id": session_id,
            "lang_code": lang_code,
            "study_mode": study_mode,
            "started_at": now,
            "finished_at": None,
            "total_words": 0,
            "total_score": 0.0,
            "average_score": 0.0,
            "tags_filter": tags_filter or [],
        }

    async def update_progress(
        self,
        session_id: int,
        total_words: int,
        total_score: float,
    ) -> bool:
        """Actualiza el progreso de una sesión."""
        average_score = total_score / total_words if total_words > 0 else 0.0

        query = """
            UPDATE study_sessions
            SET total_words = ?,
                total_score = ?,
                average_score = ?
            WHERE id = ?
        """
        rows = await self._sqlite.update(
            query,
            (total_words, total_score, round(average_score, 2), session_id)
        )
        return rows > 0

    async def finish(self, session_id: int) -> dict | None:
        """Finaliza una sesión de estudio."""
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        query = """
            UPDATE study_sessions
            SET finished_at = ?
            WHERE id = ? AND finished_at IS NULL
        """
        rows = await self._sqlite.update(query, (now, session_id))

        if rows == 0:
            return None

        # Retornar sesión actualizada
        select_query = """
            SELECT id, lang_code, study_mode, started_at, finished_at,
                   total_words, total_score, average_score, tags_filter
            FROM study_sessions
            WHERE id = ?
        """
        return await self._sqlite.fetch_one(select_query, (session_id,))

    async def delete(self, session_id: int) -> bool:
        """Elimina una sesión (y sus respuestas por CASCADE)."""
        query = "DELETE FROM study_sessions WHERE id = ?"
        rows = await self._sqlite.delete(query, (session_id,))
        return rows > 0
