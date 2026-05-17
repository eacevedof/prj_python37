"""Repositorio de lectura para word_groups."""

from typing import final, Self

from ddd.shared.infrastructure.repositories import AbstractSqliteRepository


@final
class WordGroupsReaderSqliteRepository(AbstractSqliteRepository):
    """Repositorio para lectura de grupos de palabras."""

    _instance: "WordGroupsReaderSqliteRepository | None" = None

    def __init__(self) -> None:
        super().__init__()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def get_all(self) -> list[dict]:
        """
        Obtiene todos los grupos de palabras.

        Returns:
            Lista de diccionarios con datos de grupos.
        """
        query = """
            SELECT
                id,
                title,
                description,
                created_at,
                updated_at
            FROM word_groups
            ORDER BY title ASC
        """
        return await self._query(query)

    async def get_by_id(self, group_id: int) -> dict | None:
        """
        Obtiene un grupo por su ID.

        Args:
            group_id: ID del grupo.

        Returns:
            Diccionario con datos del grupo o None si no existe.
        """
        query = """
            SELECT
                id,
                title,
                description,
                created_at,
                updated_at
            FROM word_groups
            WHERE id = ?
        """
        return await self._query_one(query, (group_id,))

    async def get_by_title(self, title: str) -> dict | None:
        """
        Obtiene un grupo por su título.

        Args:
            title: Título del grupo.

        Returns:
            Diccionario con datos del grupo o None si no existe.
        """
        query = """
            SELECT
                id,
                title,
                description,
                created_at,
                updated_at
            FROM word_groups
            WHERE title = ?
        """
        return await self._query_one(query, (title,))

    async def get_by_word(self, word_id: int) -> list[dict]:
        """
        Obtiene todos los grupos asociados a una palabra.

        Args:
            word_id: ID de la palabra.

        Returns:
            Lista de diccionarios con datos de grupos.
        """
        query = """
            SELECT
                wg.id,
                wg.title,
                wg.description,
                wg.created_at,
                wg.updated_at
            FROM word_groups wg
            INNER JOIN word_es_groups weg ON wg.id = weg.group_id
            WHERE weg.word_es_id = ?
            ORDER BY wg.title ASC
        """
        return await self._query(query, (word_id,))
