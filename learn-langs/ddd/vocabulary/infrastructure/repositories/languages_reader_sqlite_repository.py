"""Repositorio de lectura para idiomas."""

from typing import final, Self

from ddd.shared.infrastructure.repositories import AbstractSqliteRepository


@final
class LanguagesReaderSqliteRepository(AbstractSqliteRepository):
    """Repositorio de lectura para idiomas."""

    def __init__(self) -> None:
        super().__init__()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def get_by_code(self, code: str) -> dict | None:
        """Obtiene un idioma por su codigo."""
        query = """
            SELECT code, name, native_name, flag_emoji, is_active
            FROM languages
            WHERE code = ?
        """
        return await self._query_one(query, (code,))

    async def get_all(self) -> list[dict]:
        """Obtiene todos los idiomas."""
        query = """
            SELECT code, name, native_name, flag_emoji, is_active
            FROM languages
            ORDER BY name
        """
        return await self._query(query)

    async def get_active(self) -> list[dict]:
        """Obtiene todos los idiomas activos."""
        query = """
            SELECT code, name, native_name, flag_emoji, is_active
            FROM languages
            WHERE is_active = 1
            ORDER BY name
        """
        return await self._query(query)

    async def count(self) -> int:
        """Cuenta el total de idiomas."""
        query = "SELECT COUNT(*) as count FROM languages"
        result = await self._query_one(query)
        return result["count"] if result else 0
