"""Repositorio de lectura para palabras en español."""

from typing import final, Self

from ddd.shared.infrastructure.repositories import AbstractSqliteRepository


@final
class WordsEsReaderSqliteRepository(AbstractSqliteRepository):
    """Repositorio de lectura para palabras en español."""

    def __init__(self) -> None:
        super().__init__()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def get_by_id(self, word_id: int) -> dict | None:
        """Obtiene una palabra por su ID."""
        query = """
            SELECT id, text, word_type, notes, created_at, updated_at
            FROM words_es
            WHERE id = ?
        """
        return await self._query_one(query, (word_id,))

    async def get_by_text(self, text: str) -> dict | None:
        """Obtiene una palabra por su texto exacto."""
        query = """
            SELECT id, text, word_type, notes, created_at, updated_at
            FROM words_es
            WHERE text = ?
        """
        return await self._query_one(query, (text.strip(),))

    async def get_all(
        self,
        word_type: str | None = None,
        limit: int = 100,
        offset: int = 0,
    ) -> list[dict]:
        """Obtiene todas las palabras con filtros opcionales."""
        params: list = []
        where_clauses: list[str] = []

        if word_type:
            where_clauses.append("word_type = ?")
            params.append(word_type)

        where_sql = f"WHERE {' AND '.join(where_clauses)}" if where_clauses else ""

        query = f"""
            SELECT id, text, word_type, notes, created_at, updated_at
            FROM words_es
            {where_sql}
            ORDER BY updated_at DESC
            LIMIT ? OFFSET ?
        """
        params.extend([limit, offset])

        return await self._query(query, tuple(params))

    async def get_by_tags(
        self,
        tag_names: list[str],
        limit: int = 100,
        offset: int = 0,
    ) -> list[dict]:
        """Obtiene palabras filtradas por tags."""
        if not tag_names:
            return await self.get_all(limit=limit, offset=offset)

        placeholders = self._get_placeholders(len(tag_names))
        query = f"""
            SELECT DISTINCT w.id, w.text, w.word_type, w.notes,
                   w.created_at, w.updated_at
            FROM words_es w
            INNER JOIN word_es_tags wt ON w.id = wt.word_es_id
            INNER JOIN tags t ON wt.tag_id = t.id
            WHERE t.name IN ({placeholders})
            ORDER BY w.updated_at DESC
            LIMIT ? OFFSET ?
        """
        params = tuple(tag_names) + (limit, offset)

        return await self._query(query, params)

    async def get_with_translations(self, word_id: int) -> dict | None:
        """Obtiene una palabra con todas sus traducciones."""
        word = await self.get_by_id(word_id)
        if not word:
            return None

        translations_query = """
            SELECT lang_code, text, pronunciation, audio_path, notes
            FROM words_lang
            WHERE word_es_id = ?
        """
        translations = await self._query(translations_query, (word_id,))

        word["translations"] = {t["lang_code"]: t["text"] for t in translations}
        word["translations_detail"] = translations

        return word

    async def get_with_tags(self, word_id: int) -> dict | None:
        """Obtiene una palabra con sus tags."""
        word = await self.get_by_id(word_id)
        if not word:
            return None

        tags = await self.get_tags_for_word(word_id)

        word["tags"] = [t["name"] for t in tags]
        word["tags_detail"] = tags

        return word

    async def get_tags_for_word(self, word_id: int) -> list[dict]:
        """Obtiene los tags de una palabra."""
        query = """
            SELECT t.id, t.name, t.color
            FROM tags t
            INNER JOIN word_es_tags wt ON t.id = wt.tag_id
            WHERE wt.word_es_id = ?
        """
        return await self._query(query, (word_id,))

    async def search(self, text: str, limit: int = 50) -> list[dict]:
        """Busca palabras por texto (búsqueda parcial)."""
        query = """
            SELECT id, text, word_type, notes, created_at, updated_at
            FROM words_es
            WHERE text LIKE ?
            ORDER BY text
            LIMIT ?
        """
        return await self._query(query, (f"%{text}%", limit))

    async def count(self, word_type: str | None = None) -> int:
        """Cuenta el total de palabras."""
        if word_type:
            query = "SELECT COUNT(*) as count FROM words_es WHERE word_type = ?"
            return await self._query_scalar(query, (word_type,), "count") or 0
        else:
            query = "SELECT COUNT(*) as count FROM words_es"
            return await self._query_scalar(query, (), "count") or 0
