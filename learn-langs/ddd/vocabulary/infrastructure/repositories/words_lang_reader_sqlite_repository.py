from typing import final, Self

from ddd.shared.infrastructure.repositories.sqlite_connection import SqliteConnection


@final
class WordsLangReaderSqliteRepository:
    """Repositorio de lectura para traducciones."""

    _sqlite: SqliteConnection

    def __init__(self) -> None:
        self._sqlite = SqliteConnection.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def get_by_id(self, translation_id: int) -> dict | None:
        """Obtiene una traducción por su ID."""
        query = """
            SELECT id, word_es_id, lang_code, text, pronunciation, audio_path,
                   notes, created_at, updated_at
            FROM words_lang
            WHERE id = ?
        """
        return await self._sqlite.fetch_one(query, (translation_id,))

    async def get_by_word_and_lang(self, word_es_id: int, lang_code: str) -> dict | None:
        """Obtiene una traducción específica de una palabra."""
        query = """
            SELECT id, word_es_id, lang_code, text, pronunciation, audio_path,
                   notes, created_at, updated_at
            FROM words_lang
            WHERE word_es_id = ? AND lang_code = ?
        """
        return await self._sqlite.fetch_one(query, (word_es_id, lang_code))

    async def get_all_for_word(self, word_es_id: int) -> list[dict]:
        """Obtiene todas las traducciones de una palabra."""
        query = """
            SELECT id, word_es_id, lang_code, text, pronunciation, audio_path,
                   notes, created_at, updated_at
            FROM words_lang
            WHERE word_es_id = ?
            ORDER BY lang_code
        """
        return await self._sqlite.fetch_all(query, (word_es_id,))

    async def get_all_for_language(
        self,
        lang_code: str,
        limit: int = 100,
        offset: int = 0,
    ) -> list[dict]:
        """Obtiene todas las traducciones en un idioma específico."""
        query = """
            SELECT wl.id, wl.word_es_id, wl.lang_code, wl.text, wl.pronunciation,
                   wl.audio_path, wl.notes, wl.created_at, wl.updated_at,
                   we.text as text_es, we.word_type
            FROM words_lang wl
            INNER JOIN words_es we ON wl.word_es_id = we.id
            WHERE wl.lang_code = ?
            ORDER BY wl.updated_at DESC
            LIMIT ? OFFSET ?
        """
        return await self._sqlite.fetch_all(query, (lang_code, limit, offset))

    async def count_for_language(self, lang_code: str) -> int:
        """Cuenta las traducciones disponibles en un idioma."""
        query = "SELECT COUNT(*) as count FROM words_lang WHERE lang_code = ?"
        result = await self._sqlite.fetch_one(query, (lang_code,))
        return result["count"] if result else 0
