from datetime import datetime
from typing import final, Self

from ddd.shared.infrastructure.components.sqlite_connector import SqliteConnector
from ddd.vocabulary.domain.entities import WordLangEntity


@final
class WordsLangWriterSqliteRepository:
    """Repositorio de escritura para traducciones."""

    _sqlite: SqliteConnector

    def __init__(self) -> None:
        self._sqlite = SqliteConnector.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def create(self, word_lang_entity: WordLangEntity) -> int:
        """Crea una nueva traducción y retorna el ID generado."""
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        query = """
            INSERT INTO words_lang
            (word_es_id, lang_code, text, pronunciation, audio_path, notes, created_at, updated_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        """
        translation_id = await self._sqlite.insert(
            query,
            (
                word_lang_entity.word_es_id,
                word_lang_entity.lang_code,
                word_lang_entity.text.strip(),
                word_lang_entity.pronunciation,
                word_lang_entity.audio_path,
                word_lang_entity.notes,
                now,
                now,
            ),
        )

        return translation_id

    async def update(self, word_lang_entity: WordLangEntity) -> bool:
        """Actualiza una traducción existente."""
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        query = """
            UPDATE words_lang
            SET text = ?, pronunciation = ?, audio_path = ?, notes = ?, updated_at = ?
            WHERE id = ?
        """
        rows_affected = await self._sqlite.update(
            query,
            (
                word_lang_entity.text.strip(),
                word_lang_entity.pronunciation,
                word_lang_entity.audio_path,
                word_lang_entity.notes,
                now,
                word_lang_entity.id,
            ),
        )

        return rows_affected > 0

    async def delete(self, word_lang_entity: WordLangEntity) -> bool:
        """Elimina una traducción."""
        query = "DELETE FROM words_lang WHERE id = ?"
        rows_affected = await self._sqlite.delete(query, (word_lang_entity.id,))
        return rows_affected > 0

    async def delete_by_word_and_lang(self, word_es_id: int, lang_code: str) -> bool:
        """Elimina una traducción específica de una palabra."""
        query = "DELETE FROM words_lang WHERE word_es_id = ? AND lang_code = ?"
        rows_affected = await self._sqlite.delete(query, (word_es_id, lang_code))
        return rows_affected > 0
