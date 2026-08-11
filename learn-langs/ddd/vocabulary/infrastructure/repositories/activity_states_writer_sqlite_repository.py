"""Repositorio de escritura para estados de actividad (retomar sesión)."""

import json
from typing import final, Self

from ddd.shared.infrastructure.repositories import AbstractSqliteRepository


@final
class ActivityStatesWriterSqliteRepository(AbstractSqliteRepository):
    """Repositorio de escritura para la tabla activity_states."""

    def __init__(self) -> None:
        super().__init__()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def upsert_activity_state(
        self,
        activity: str,
        lang_code: str,
        tags: list[str],
        group_id: int | None,
        word_es_id: int,
        word_index: int,
        total_words: int,
        is_random_order: bool,
    ) -> int:
        """Guarda (o actualiza) el estado de una actividad. Una fila por actividad."""
        return await self._sqlite.update(
            """
            INSERT INTO activity_states
                (activity, lang_code, tags, group_id, word_es_id,
                 word_index, total_words, is_random_order, updated_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, datetime('now'))
            ON CONFLICT(activity) DO UPDATE SET
                lang_code = excluded.lang_code,
                tags = excluded.tags,
                group_id = excluded.group_id,
                word_es_id = excluded.word_es_id,
                word_index = excluded.word_index,
                total_words = excluded.total_words,
                is_random_order = excluded.is_random_order,
                updated_at = datetime('now')
            """,
            (
                activity,
                lang_code,
                json.dumps(tags or []),
                group_id,
                word_es_id,
                word_index,
                total_words,
                1 if is_random_order else 0,
            ),
        )

    async def delete_activity_state(self, activity: str) -> int:
        """Borra el estado de una actividad (al completar la sesión)."""
        return await self._delete_where(
            "activity_states",
            "activity = ?",
            (activity,),
        )

    async def soft_clear_activity_state(self, activity: str) -> int:
        """Marca la actividad como NO retomable (posición a 0) pero CONSERVA
        lang_code/tags/group_id como 'último grupo practicado', para que el selector
        de grupo del Home lo recuerde tras completar o abortar el examen/aprendizaje."""
        return await self._sqlite.update(
            """
            UPDATE activity_states
            SET word_es_id = 0,
                word_index = 0,
                total_words = 0,
                updated_at = datetime('now')
            WHERE activity = ?
            """,
            (activity,),
        )
