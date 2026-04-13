from datetime import datetime
from typing import final, Self

from ddd.shared.infrastructure.repositories.sqlite_connection import SqliteConnection
from ddd.vocabulary.domain.entities import SessionAnswerEntity


@final
class AnswersWriterSqliteRepository:
    """Repositorio de escritura para respuestas de sesión."""

    _sqlite: SqliteConnection

    def __init__(self) -> None:
        self._sqlite = SqliteConnection.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def create(self, session_answer_entity: SessionAnswerEntity) -> int:
        """Registra una respuesta en la sesión y retorna el ID generado."""
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        query = """
            INSERT INTO session_answers
            (session_id, word_es_id, user_input, expected_text, score,
             response_time_ms, answered_at)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        """
        answer_id = await self._sqlite.insert(
            query,
            (
                session_answer_entity.session_id,
                session_answer_entity.word_es_id,
                session_answer_entity.user_input,
                session_answer_entity.expected_text,
                session_answer_entity.score,
                session_answer_entity.response_time_ms,
                now,
            ),
        )

        return answer_id
