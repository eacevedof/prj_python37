"""Repositorio de lectura para tags."""

from typing import final, Self

from ddd.shared.infrastructure.repositories import AbstractSqliteRepository


@final
class TagsReaderSqliteRepository(AbstractSqliteRepository):
    """Repositorio de lectura para tags."""

    def __init__(self) -> None:
        super().__init__()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def get_by_id(self, tag_id: int) -> dict | None:
        """Obtiene un tag por su ID."""
        query = f"""
            SELECT id, name, color, created_at FROM tags
            WHERE 1=1
            AND id = {tag_id}
        """
        return await self._query_one(query)

    async def get_by_name(self, name: str) -> dict | None:
        """Obtiene un tag por su nombre."""
        query = """
            SELECT id, name, color, created_at FROM tags
            WHERE 1=1
            AND name = ?
        """
        return await self._query_one(query, (name.strip(),))

    async def get_all(self) -> list[dict]:
        """Obtiene todos los tags."""
        query = "SELECT id, name, color, created_at FROM tags ORDER BY name"
        return await self._query(query)

    async def get_by_names(self, names: list[str]) -> list[dict]:
        """Obtiene tags por lista de nombres."""
        if not names:
            return []

        placeholders = self._get_placeholders(len(names))
        query = f"""
            SELECT id, name, color, created_at FROM tags
            WHERE 1=1
            AND name IN ({placeholders})
        """
        return await self._query(query, tuple(names))

    async def get_for_word(self, word_es_id: int) -> list[dict]:
        """Obtiene todos los tags de una palabra."""
        query = f"""
            SELECT t.id, t.name, t.color, t.created_at
            FROM tags t
            INNER JOIN word_es_tags wt ON t.id = wt.tag_id
            WHERE 1=1
            AND wt.word_es_id = {word_es_id}
            ORDER BY t.name
        """
        return await self._query(query)
