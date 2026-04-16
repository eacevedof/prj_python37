"""Repository de lectura de imagenes."""

from typing import final, Self

from ddd.shared.infrastructure.components.sqlite_connector import SqliteConnector


@final
class ImagesReaderSqliteRepository:
    """Repository para leer imagenes de palabras."""

    _instance: "ImagesReaderSqliteRepository | None" = None

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def get_by_id(self, image_id: int) -> dict | None:
        """Obtiene una imagen por ID."""
        sqlite = SqliteConnector.get_instance()
        return await sqlite.fetch_one(
            "SELECT * FROM word_es_images WHERE id = ? AND is_active = 1",
            (image_id,),
        )

    async def get_by_word_id(self, word_es_id: int) -> list[dict]:
        """Obtiene todas las imagenes de una palabra."""
        sqlite = SqliteConnector.get_instance()
        return await sqlite.fetch_all(
            """
            SELECT * FROM word_es_images
            WHERE word_es_id = ? AND is_active = 1
            ORDER BY is_primary DESC, sort_order ASC, created_at ASC
            """,
            (word_es_id,),
        )

    async def get_primary_by_word_id(self, word_es_id: int) -> dict | None:
        """Obtiene la imagen principal de una palabra."""
        sqlite = SqliteConnector.get_instance()
        return await sqlite.fetch_one(
            """
            SELECT * FROM word_es_images
            WHERE word_es_id = ? AND is_primary = 1 AND is_active = 1
            """,
            (word_es_id,),
        )

    async def get_by_source_type(self, source_type: str, limit: int = 50) -> list[dict]:
        """Obtiene imagenes por tipo de fuente."""
        sqlite = SqliteConnector.get_instance()
        return await sqlite.fetch_all(
            """
            SELECT * FROM word_es_images
            WHERE source_type = ? AND is_active = 1
            ORDER BY created_at DESC
            LIMIT ?
            """,
            (source_type, limit),
        )

    async def count_by_word_id(self, word_es_id: int) -> int:
        """Cuenta las imagenes de una palabra."""
        sqlite = SqliteConnector.get_instance()
        result = await sqlite.fetch_one(
            "SELECT COUNT(*) as count FROM word_es_images WHERE word_es_id = ? AND is_active = 1",
            (word_es_id,),
        )
        return result["count"] if result else 0

    async def get_words_with_images(self, limit: int = 50) -> list[dict]:
        """Obtiene palabras que tienen imagenes con su imagen principal."""
        sqlite = SqliteConnector.get_instance()
        return await sqlite.fetch_all(
            """
            SELECT w.*, i.file_path as primary_image_path, i.mime_type as primary_image_mime
            FROM words_es w
            INNER JOIN word_es_images i ON w.id = i.word_es_id
            WHERE i.is_primary = 1 AND i.is_active = 1
            ORDER BY w.created_at DESC
            LIMIT ?
            """,
            (limit,),
        )
