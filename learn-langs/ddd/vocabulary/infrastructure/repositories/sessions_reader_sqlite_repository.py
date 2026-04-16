"""Repositorio de lectura para sesiones de estudio."""

from typing import final, Self

from ddd.shared.infrastructure.repositories import AbstractSqliteRepository


@final
class SessionsReaderSqliteRepository(AbstractSqliteRepository):
    """Repositorio de lectura para sesiones de estudio."""

    def __init__(self) -> None:
        super().__init__()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def get_by_id(self, session_id: int) -> dict | None:
        """Obtiene una sesión por su ID."""
        return await self._query_one(
            """
            SELECT id, lang_code, study_mode, started_at, finished_at,
                   total_words, total_score, average_score, tags_filter
            FROM study_sessions
            WHERE id = ?
            """,
            (session_id,),
        )

    async def get_active_session(self, lang_code: str | None = None) -> dict | None:
        """Obtiene la sesión activa (sin finalizar)."""
        if lang_code:
            return await self._query_one(
                """
                SELECT id, lang_code, study_mode, started_at, finished_at,
                       total_words, total_score, average_score, tags_filter
                FROM study_sessions
                WHERE finished_at IS NULL AND lang_code = ?
                ORDER BY started_at DESC
                LIMIT 1
                """,
                (lang_code,),
            )
        else:
            return await self._query_one(
                """
                SELECT id, lang_code, study_mode, started_at, finished_at,
                       total_words, total_score, average_score, tags_filter
                FROM study_sessions
                WHERE finished_at IS NULL
                ORDER BY started_at DESC
                LIMIT 1
                """,
            )

    async def get_recent_sessions(
        self,
        lang_code: str | None = None,
        limit: int = 10,
    ) -> list[dict]:
        """Obtiene las sesiones recientes."""
        if lang_code:
            return await self._query(
                """
                SELECT id, lang_code, study_mode, started_at, finished_at,
                       total_words, total_score, average_score, tags_filter
                FROM study_sessions
                WHERE lang_code = ?
                ORDER BY started_at DESC
                LIMIT ?
                """,
                (lang_code, limit),
            )
        else:
            return await self._query(
                """
                SELECT id, lang_code, study_mode, started_at, finished_at,
                       total_words, total_score, average_score, tags_filter
                FROM study_sessions
                ORDER BY started_at DESC
                LIMIT ?
                """,
                (limit,),
            )

    async def get_stats(
        self,
        lang_code: str | None = None,
        days: int = 30,
    ) -> dict:
        """Obtiene estadísticas de sesiones."""
        if lang_code:
            result = await self._query_one(
                """
                SELECT
                    COUNT(*) as total_sessions,
                    SUM(total_words) as total_words_studied,
                    AVG(average_score) as avg_session_score,
                    SUM(CASE WHEN finished_at IS NOT NULL THEN 1 ELSE 0 END) as completed_sessions
                FROM study_sessions
                WHERE lang_code = ?
                  AND started_at >= datetime('now', ?)
                """,
                (lang_code, f"-{days} days"),
            )
        else:
            result = await self._query_one(
                """
                SELECT
                    COUNT(*) as total_sessions,
                    SUM(total_words) as total_words_studied,
                    AVG(average_score) as avg_session_score,
                    SUM(CASE WHEN finished_at IS NOT NULL THEN 1 ELSE 0 END) as completed_sessions
                FROM study_sessions
                WHERE started_at >= datetime('now', ?)
                """,
                (f"-{days} days",),
            )

        return result or {
            "total_sessions": 0,
            "total_words_studied": 0,
            "avg_session_score": 0.0,
            "completed_sessions": 0,
        }
