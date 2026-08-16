"""Repositorio de escritura de la tabla word_es_media (datasource: sqlite)."""

from typing import final, Self

from ddd.shared.infrastructure.repositories import AbstractSqliteRepository


@final
class WordMediaWriterSqliteRepository(AbstractSqliteRepository):
    """Escritura de los media (audio/video/pdf...) de las palabras."""

    def __init__(self) -> None:
        super().__init__()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def upsert(
        self,
        word_es_id: int,
        lang_code: str,
        file_ext: str,
        filename: str,
        file_url: str,
        file_synced_md5: str,
    ) -> None:
        """Inserta o actualiza el media de (word_es_id, lang_code, file_ext).

        Preserva id/created_at en la actualizacion (ON CONFLICT DO UPDATE).
        """
        await self._sqlite_connector.insert(
            """
            INSERT INTO word_es_media
                (word_es_id, lang_code, file_ext, filename, file_url, file_synced_md5)
            VALUES (?, ?, ?, ?, ?, ?)
            ON CONFLICT(word_es_id, lang_code, file_ext) DO UPDATE SET
                filename = excluded.filename,
                file_url = excluded.file_url,
                file_synced_md5 = excluded.file_synced_md5,
                updated_at = datetime('now')
            """,
            (word_es_id, lang_code, file_ext, filename, file_url, file_synced_md5),
        )
