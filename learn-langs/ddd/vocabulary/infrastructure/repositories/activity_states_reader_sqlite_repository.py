"""Repositorio de lectura para estados de actividad (retomar sesión)."""

import json
from typing import final, Self

from ddd.shared.infrastructure.repositories import AbstractSqliteRepository


@final
class ActivityStatesReaderSqliteRepository(AbstractSqliteRepository):
    """Repositorio de lectura para la tabla activity_states."""

    def __init__(self) -> None:
        super().__init__()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def get_last_activity_state(self) -> dict | None:
        """Obtiene el estado de actividad más reciente (o None si no hay)."""
        row = await self._query_one(
            """
            -- get_last_activity_state
            SELECT activity, lang_code, tags, group_id, word_es_id,
                   word_index, total_words, is_random_order, updated_at
            FROM activity_states
            ORDER BY updated_at DESC
            LIMIT 1
            """,
        )
        return self._parse_row(row)

    @staticmethod
    def _parse_row(row: dict | None) -> dict | None:
        """Deserializa la fila (tags JSON -> list, flags -> bool)."""
        if not row:
            return None

        parsed = dict(row)
        try:
            parsed["tags"] = json.loads(row.get("tags") or "[]")
        except (ValueError, TypeError):
            parsed["tags"] = []
        parsed["is_random_order"] = bool(row.get("is_random_order", 0))
        return parsed
