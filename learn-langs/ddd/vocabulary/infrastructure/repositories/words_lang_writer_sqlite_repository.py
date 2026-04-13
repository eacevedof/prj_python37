from datetime import datetime
from typing import final, Self

from ddd.shared.infrastructure.repositories.sqlite_connection import SqliteConnection


@final
class WordsLangWriterSqliteRepository:
    """Repositorio de escritura para traducciones."""

    _sqlite: SqliteConnection

    def __init__(self) -> None:
        self._sqlite = SqliteConnection.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def create(
        self,
        word_es_id: int,
        lang_code: str,
        text: str,
        pronunciation: str = "",
        audio_path: str = "",
        notes: str = "",
    ) -> dict:
        """Crea una nueva traducción."""
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        query = """
            INSERT INTO words_lang
            (word_es_id, lang_code, text, pronunciation, audio_path, notes, created_at, updated_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        """
        translation_id = await self._sqlite.insert(
            query,
            (word_es_id, lang_code, text.strip(), pronunciation, audio_path, notes, now, now)
        )

        return {
            "id": translation_id,
            "word_es_id": word_es_id,
            "lang_code": lang_code,
            "text": text.strip(),
            "pronunciation": pronunciation,
            "audio_path": audio_path,
            "notes": notes,
            "created_at": now,
            "updated_at": now,
        }

    async def update(
        self,
        translation_id: int,
        text: str | None = None,
        pronunciation: str | None = None,
        audio_path: str | None = None,
        notes: str | None = None,
    ) -> dict | None:
        """Actualiza una traducción existente."""
        updates: list[str] = []
        params: list = []

        if text is not None:
            updates.append("text = ?")
            params.append(text.strip())

        if pronunciation is not None:
            updates.append("pronunciation = ?")
            params.append(pronunciation)

        if audio_path is not None:
            updates.append("audio_path = ?")
            params.append(audio_path)

        if notes is not None:
            updates.append("notes = ?")
            params.append(notes)

        if not updates:
            return None

        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        updates.append("updated_at = ?")
        params.append(now)
        params.append(translation_id)

        query = f"""
            UPDATE words_lang
            SET {', '.join(updates)}
            WHERE id = ?
        """
        rows_affected = await self._sqlite.update(query, tuple(params))

        if rows_affected == 0:
            return None

        select_query = """
            SELECT id, word_es_id, lang_code, text, pronunciation, audio_path,
                   notes, created_at, updated_at
            FROM words_lang
            WHERE id = ?
        """
        return await self._sqlite.fetch_one(select_query, (translation_id,))

    async def delete(self, translation_id: int) -> bool:
        """Elimina una traducción."""
        query = "DELETE FROM words_lang WHERE id = ?"
        rows_affected = await self._sqlite.delete(query, (translation_id,))
        return rows_affected > 0

    async def delete_by_word_and_lang(self, word_es_id: int, lang_code: str) -> bool:
        """Elimina una traducción específica de una palabra."""
        query = "DELETE FROM words_lang WHERE word_es_id = ? AND lang_code = ?"
        rows_affected = await self._sqlite.delete(query, (word_es_id, lang_code))
        return rows_affected > 0
