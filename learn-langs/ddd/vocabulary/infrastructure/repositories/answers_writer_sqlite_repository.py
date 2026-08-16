"""Repositorio de escritura para respuestas de sesión."""

from datetime import datetime
from typing import final, Self

from ddd.shared.infrastructure.repositories import AbstractSqliteRepository
from ddd.vocabulary.domain.entities import SessionAnswerEntity


@final
class AnswersWriterSqliteRepository(AbstractSqliteRepository):
    """Repositorio de escritura para respuestas de sesión."""

    def __init__(self) -> None:
        super().__init__()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def create(self, session_answer_entity: SessionAnswerEntity) -> int:
        """Registra una respuesta en la sesión y retorna el ID generado."""
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        return await self._insert_into("session_answers", {
            "session_id": session_answer_entity.session_id,
            "word_es_id": session_answer_entity.word_es_id,
            "user_input": session_answer_entity.user_input,
            "expected_text": session_answer_entity.expected_text,
            "score": session_answer_entity.score,
            "response_time_ms": session_answer_entity.response_time_ms,
            "answered_at": now,
        })
