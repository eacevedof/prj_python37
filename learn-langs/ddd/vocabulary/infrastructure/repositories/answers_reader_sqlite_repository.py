"""Repositorio de lectura para respuestas de sesión."""

from typing import final, Self

from ddd.shared.infrastructure.repositories import AbstractSqliteRepository


@final
class AnswersReaderSqliteRepository(AbstractSqliteRepository):
    """Repositorio de lectura para respuestas de sesión."""

    def __init__(self) -> None:
        super().__init__()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def get_by_session(self, session_id: int) -> list[dict]:
        """Obtiene todas las respuestas de una sesión."""
        return await self._query(
            """
            SELECT sa.id, sa.session_id, sa.word_es_id, sa.user_input,
                   sa.expected_text, sa.score, sa.response_time_ms, sa.answered_at,
                   we.text as text_es
            FROM session_answers sa
            INNER JOIN words_es we ON sa.word_es_id = we.id
            WHERE sa.session_id = ?
            ORDER BY sa.answered_at
            """,
            (session_id,),
        )

    async def get_session_summary(self, session_id: int) -> dict:
        """Obtiene resumen de respuestas de una sesión."""
        result = await self._query_one(
            """
            SELECT
                COUNT(*) as total_answers,
                SUM(CASE WHEN score >= 1.0 THEN 1 ELSE 0 END) as correct,
                SUM(CASE WHEN score > 0 AND score < 1.0 THEN 1 ELSE 0 END) as partial,
                SUM(CASE WHEN score = 0 THEN 1 ELSE 0 END) as incorrect,
                AVG(score) as average_score,
                AVG(response_time_ms) as avg_response_time
            FROM session_answers
            WHERE session_id = ?
            """,
            (session_id,),
        )
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
        return await self._query(
            """
            SELECT sa.id, sa.session_id, sa.user_input, sa.expected_text,
                   sa.score, sa.response_time_ms, sa.answered_at,
                   ss.lang_code, ss.study_mode
            FROM session_answers sa
            INNER JOIN study_sessions ss ON sa.session_id = ss.id
            WHERE sa.word_es_id = ?
            ORDER BY sa.answered_at DESC
            LIMIT ?
            """,
            (word_es_id, limit),
        )
