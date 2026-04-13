from datetime import datetime
from typing import final, Self

from ddd.shared.infrastructure.repositories.sqlite_connection import SqliteConnection


@final
class AnswersWriterSqliteRepository:
    """Repositorio de escritura para respuestas de sesión."""

    _sqlite: SqliteConnection

    def __init__(self) -> None:
        self._sqlite = SqliteConnection.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def create(
        self,
        session_id: int,
        word_es_id: int,
        expected_text: str,
        user_input: str | None,
        score: float,
        response_time_ms: int | None = None,
    ) -> dict:
        """Registra una respuesta en la sesión."""
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        query = """
            INSERT INTO session_answers
            (session_id, word_es_id, user_input, expected_text, score,
             response_time_ms, answered_at)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        """
        answer_id = await self._sqlite.insert(
            query,
            (session_id, word_es_id, user_input, expected_text, score,
             response_time_ms, now)
        )

        return {
            "id": answer_id,
            "session_id": session_id,
            "word_es_id": word_es_id,
            "user_input": user_input,
            "expected_text": expected_text,
            "score": score,
            "response_time_ms": response_time_ms,
            "answered_at": now,
        }
