"""Repositorio de lectura de la tabla word_es_media (datasource: sqlite)."""

from typing import final, Self

from ddd.shared.infrastructure.repositories import AbstractSqliteRepository


@final
class WordMediaReaderSqliteRepository(AbstractSqliteRepository):
    """Lectura de los media (audio/video/pdf...) de las palabras."""

    def __init__(self) -> None:
        super().__init__()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def get_all(self) -> list[dict]:
        """Todas las filas de media (para construir el lookup del sync)."""
        return await self._query(
            """
            SELECT id, word_es_id, lang_code, file_ext, filename, file_url, file_synced_md5
            FROM word_es_media
            ORDER BY id
            """,
        )
