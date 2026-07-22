"""Repositorio de lectura para sesiones de estudio."""

from typing import final, Self

from ddd.shared.infrastructure.components.json_parser import JsonParser
from ddd.shared.infrastructure.repositories import AbstractSqliteRepository


@final
class SessionsReaderSqliteRepository(AbstractSqliteRepository):
    """Repositorio de lectura para sesiones de estudio."""

    def __init__(self) -> None:
        super().__init__()
        self._json_parser = JsonParser.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def _with_parsed_tags(self, row: dict | None) -> dict | None:
        """Deserializa la columna JSON tags_filter -> list (frontera de persistencia)."""
        if not row:
            return row
        row["tags_filter"] = self._json_parser.parse_list(row.get("tags_filter"))
        return row

    def _with_parsed_tags_rows(self, rows: list[dict]) -> list[dict]:
        """Aplica _with_parsed_tags a cada fila."""
        for row in rows:
            row["tags_filter"] = self._json_parser.parse_list(row.get("tags_filter"))
        return rows

    async def get_study_session_by_study_session_id(self, session_id: int) -> dict | None:
        """Obtiene una sesión por su ID."""
        row = await self._query_one(
            """
            -- get_study_session_by_study_session_id
            SELECT id, lang_code, study_mode, started_at, finished_at,
                   total_words, total_score, average_score, tags_filter
            FROM study_sessions
            WHERE 1=1
            AND id = ?
            """,
            (session_id,),
        )
        return self._with_parsed_tags(row)

    async def get_active_study_sessions_by_lang_code(self, lang_code: str | None = None) -> dict | None:
        """Obtiene la sesión activa (sin finalizar)."""
        if lang_code:
            row = await self._query_one(
                """
                -- get_active_study_sessions_by_lang_code 1
                SELECT id, lang_code, study_mode, started_at, finished_at,
                       total_words, total_score, average_score, tags_filter
                FROM study_sessions
                WHERE 1=1
                AND finished_at IS NULL
                AND lang_code = ?
                ORDER BY started_at DESC
                LIMIT 1
                """,
                (lang_code,),
            )
        else:
            row = await self._query_one(
                """
                -- get_active_study_sessions_by_lang_code 2
                SELECT id, lang_code, study_mode, started_at, finished_at,
                       total_words, total_score, average_score, tags_filter
                FROM study_sessions
                WHERE 1=1
                AND finished_at IS NULL
                ORDER BY started_at DESC
                LIMIT 1
                """,
            )
        return self._with_parsed_tags(row)

    async def get_recent_sessions_by_lang_code(
        self,
        lang_code: str | None = None,
        limit: int = 10,
    ) -> list[dict]:
        """Obtiene las sesiones recientes."""
        if lang_code:
            rows = await self._query(
                """
                -- get_recent_sessions_by_lang_code
                SELECT
                    id, lang_code, study_mode, started_at, finished_at, total_words,
                    total_score, average_score, tags_filter
                FROM study_sessions
                WHERE 1=1
                AND lang_code = ?
                ORDER BY started_at DESC
                LIMIT ?
                """,
                (lang_code, limit),
            )
        else:
            rows = await self._query(
                """
                -- get_recent_sessions_by_lang_code
                SELECT
                    id, lang_code, study_mode, started_at, finished_at, total_words,
                    total_score, average_score, tags_filter
                FROM study_sessions
                WHERE 1=1
                ORDER BY started_at DESC
                LIMIT ?
                """,
                (limit,),
            )
        return self._with_parsed_tags_rows(rows)

    async def get_study_sessions_stats_by_lang_code(
        self,
        lang_code: str | None = None,
        days: int = 30,
    ) -> dict:
        """Obtiene estadísticas de sesiones."""
        if lang_code:
            result = await self._query_one(
                """
                -- get_study_sessions_stats_by_lang_code 1
                SELECT
                    COUNT(*) as total_sessions,
                    SUM(total_words) as total_words_studied,
                    AVG(average_score) as avg_session_score,
                    SUM(CASE WHEN finished_at IS NOT NULL THEN 1 ELSE 0 END) as completed_sessions
                FROM study_sessions
                WHERE 1=1
                AND lang_code = ?
                AND started_at >= datetime('now', ?)
                """,
                (lang_code, f"-{days} days"),
            )
        else:
            result = await self._query_one(
                """
                -- get_study_sessions_stats_by_lang_code 2
                SELECT
                    COUNT(*) as total_sessions,
                    SUM(total_words) as total_words_studied,
                    AVG(average_score) as avg_session_score,
                    SUM(CASE WHEN finished_at IS NOT NULL THEN 1 ELSE 0 END) as completed_sessions
                FROM study_sessions
                WHERE 1=1
                AND started_at >= datetime('now', ?)
                """,
                (f"-{days} days",),
            )

        return result or {
            "total_sessions": 0,
            "total_words_studied": 0,
            "avg_session_score": 0.0,
            "completed_sessions": 0,
        }
