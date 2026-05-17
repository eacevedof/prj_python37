"""Repository de lectura de imagenes."""

from typing import final, Self

from ddd.shared.infrastructure.repositories import AbstractSqliteRepository


@final
class ImagesReaderSqliteRepository(AbstractSqliteRepository):
    """Repository para leer imagenes de palabras."""

    _instance: "ImagesReaderSqliteRepository | None" = None

    def __init__(self) -> None:
        super().__init__()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def get_word_es_image_by_word_es_image_id(self, word_es_image_id: int) -> dict | None:
        """Obtiene una imagen por ID."""
        return await self._query_one(
            f"""
            SELECT *
            FROM word_es_images
            WHERE 1=1
            AND is_active = 1
            AND id = {word_es_image_id}
            """,
        )

    async def get_word_es_images_by_word_es_id(self, word_es_id: int) -> list[dict]:
        """Obtiene todas las imagenes de una palabra."""
        return await self._query(
            f"""
            SELECT *
            FROM word_es_images
            WHERE 1=1
            AND is_active = 1
            AND word_es_id = {word_es_id}
            ORDER BY is_primary DESC, sort_order ASC, created_at ASC
            """,
        )

    async def get_primary_wore_es_image_by_word_id(self, word_es_id: int) -> dict | None:
        """Obtiene la imagen principal de una palabra."""
        return await self._query_one(
            f"""
            SELECT *
            FROM word_es_images
            WHERE 1=1
            AND is_primary = 1
            AND is_active = 1
            AND word_es_id = {word_es_id}
            """,
        )

    async def get_word_es_images_by_source_type(self, source_type: str, limit: int = 50) -> list[dict]:
        """Obtiene imagenes por tipo de fuente."""
        return await self._query(
            f"""
            SELECT *
            FROM word_es_images
            WHERE 1=1
            AND is_active = 1
            AND source_type = ?
            ORDER BY created_at DESC
            LIMIT {limit}
            """,
            (source_type,),
        )

    async def get_total_word_es_images_by_word_id(self, word_es_id: int) -> int:
        """Cuenta las imagenes de una palabra."""
        return await self._query_scalar(
            f"""
            SELECT COUNT(*) as count
            FROM word_es_images
            WHERE 1=1
            AND is_active = 1
            AND word_es_id = {word_es_id}
            """,
            (),
            "count",
        ) or 0

    async def get_all_words_es_with_images(self, limit: int = 50) -> list[dict]:
        """Obtiene palabras que tienen imagenes con su imagen principal."""
        return await self._query(
            f"""
            SELECT
                w.*,
                i.file_path as primary_image_path,
                i.mime_type as primary_image_mime
            FROM words_es w
            INNER JOIN word_es_images i
            ON w.id = i.word_es_id
            WHERE 1=1
            AND i.is_primary = 1
            AND i.is_active = 1
            ORDER BY w.created_at DESC
            LIMIT {limit}
            """,
        )
