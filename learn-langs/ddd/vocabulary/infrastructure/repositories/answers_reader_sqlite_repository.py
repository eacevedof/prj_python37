from typing import final, Self

from ddd.shared.infrastructure.repositories.sqlite_connection import SqliteConnection


@final
class AnswersReaderSqliteRepository:
    """Repositorio de lectura para respuestas de sesión."""

    _sqlite: SqliteConnection

    def __init__(self) -> None:
        self._sqlite = SqliteConnection.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def get_by_session(self, session_id: int) -> list[dict]:
        """Obtiene todas las respuestas de una sesión."""
        query = """
            SELECT sa.id, sa.session_id, sa.word_es_id, sa.user_input,
                   sa.expected_text, sa.score, sa.response_time_ms, sa.answered_at,
                   we.text as text_es
            FROM session_answers sa
            INNER JOIN words_es we ON sa.word_es_id = we.id
            WHERE sa.session_id = ?
            ORDER BY sa.answered_at
        """
        return await self._sqlite.fetch_all(query, (session_id,))

    async def get_session_summary(self, session_id: int) -> dict:
        """Obtiene resumen de respuestas de una sesión."""
        query = """
            SELECT
                COUNT(*) as total_answers,
                SUM(CASE WHEN score >= 1.0 THEN 1 ELSE 0 END) as correct,
                SUM(CASE WHEN score > 0 AND score < 1.0 THEN 1 ELSE 0 END) as partial,
                SUM(CASE WHEN score = 0 THEN 1 ELSE 0 END) as incorrect,
                AVG(score) as average_score,
                AVG(response_time_ms) as avg_response_time
            FROM session_answers
            WHERE session_id = ?
        """
        result = await self._sqlite.fetch_one(query, (session_id,))
        return result or {
            "total_answers": 0,
            "correct": 0,
            "partial": 0,
            "incorrect": 0,
            "average_score": 0.0,
            "avg_response_time": 0,
        }

    async def get_word_history(
        self,
        word_es_id: int,
        limit: int = 20,
    ) -> list[dict]:
        """Obtiene historial de respuestas para una palabra."""
        query = """
            SELECT sa.id, sa.session_id, sa.user_input, sa.expected_text,
                   sa.score, sa.response_time_ms, sa.answered_at,
                   ss.lang_code, ss.study_mode
            FROM session_answers sa
            INNER JOIN study_sessions ss ON sa.session_id = ss.id
            WHERE sa.word_es_id = ?
            ORDER BY sa.answered_at DESC
            LIMIT ?
        """
        return await self._sqlite.fetch_all(query, (word_es_id, limit))
