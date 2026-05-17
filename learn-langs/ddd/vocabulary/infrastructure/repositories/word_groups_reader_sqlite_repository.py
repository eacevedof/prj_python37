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

    async def get_all_word_groups(self) -> list[dict]:
        """
        Obtiene todos los grupos de palabras con el conteo de palabras.

        Returns:
            Lista de diccionarios con datos de grupos y word_count.
        """
        query = """
        -- get_all_word_groups
        SELECT
            wg.id, wg.title, wg.description,
            wg.created_at, wg.updated_at,
            COUNT(weg.word_es_id) as word_count
        FROM word_groups wg
        LEFT JOIN word_es_groups weg
        ON wg.id = weg.group_id
        WHERE 1=1
        GROUP BY wg.id, wg.title, wg.description, wg.created_at, wg.updated_at
        ORDER BY wg.title ASC
        """
        return await self._query(query)

    async def get_word_group_by_group_id(self, group_id: int) -> dict | None:
        """
        Obtiene un grupo por su ID.

        Args:
            group_id: ID del grupo.

        Returns:
            Diccionario con datos del grupo o None si no existe.
        """
        query = f"""
        -- get_word_group_by_group_id
        SELECT
            id, title, description, created_at, updated_at
        FROM word_groups
        WHERE 1=1
        AND id = {group_id}
        """
        return await self._query_one(query, ())

    async def get_word_group_by_title(self, title: str) -> dict | None:
        """
        Obtiene un grupo por su título.

        Args:
            title: Título del grupo.

        Returns:
            Diccionario con datos del grupo o None si no existe.
        """
        query = """
        -- get_word_group_by_title
        SELECT
            id, title, description, created_at, updated_at
        FROM word_groups
        WHERE 1=1
        AND title = ?
        """
        return await self._query_one(query, (title,))

    async def get_word_group_by_word_es_id(self, word_es_id: int) -> list[dict]:
        """
        Obtiene todos los grupos asociados a una palabra.

        Args:
            word_es_id: ID de la palabra.

        Returns:
            Lista de diccionarios con datos de grupos.
        """
        query = f"""
        -- get_word_group_by_word_es_id
        SELECT
            wg.id, wg.title, wg.description, wg.created_at, wg.updated_at
        FROM word_groups wg
        INNER JOIN word_es_groups weg
        ON wg.id = weg.group_id
        WHERE 1=1
        AND weg.word_es_id = {word_es_id}
        ORDER BY wg.title ASC
        """
        return await self._query(query, ())
