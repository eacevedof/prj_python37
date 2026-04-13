from datetime import datetime
from typing import final, Self

from ddd.shared.infrastructure.repositories.sqlite_connection import SqliteConnection


@final
class WordsEsWriterSqliteRepository:
    """Repositorio de escritura para palabras en español."""

    _sqlite: SqliteConnection

    def __init__(self) -> None:
        self._sqlite = SqliteConnection.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def create(
        self,
        text: str,
        word_type: str = "WORD",
        image_path: str = "",
        notes: str = "",
    ) -> dict:
        """Crea una nueva palabra."""
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        query = """
            INSERT INTO words_es (text, word_type, image_path, notes, created_at, updated_at)
            VALUES (?, ?, ?, ?, ?, ?)
        """
        word_id = await self._sqlite.insert(
            query,
            (text.strip(), word_type, image_path, notes, now, now)
        )

        return {
            "id": word_id,
            "text": text.strip(),
            "word_type": word_type,
            "image_path": image_path,
            "notes": notes,
            "created_at": now,
            "updated_at": now,
        }

    async def update(
        self,
        word_id: int,
        text: str | None = None,
        word_type: str | None = None,
        image_path: str | None = None,
        notes: str | None = None,
    ) -> dict | None:
        """Actualiza una palabra existente."""
        updates: list[str] = []
        params: list = []

        if text is not None:
            updates.append("text = ?")
            params.append(text.strip())

        if word_type is not None:
            updates.append("word_type = ?")
            params.append(word_type)

        if image_path is not None:
            updates.append("image_path = ?")
            params.append(image_path)

        if notes is not None:
            updates.append("notes = ?")
            params.append(notes)

        if not updates:
            return None

        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        updates.append("updated_at = ?")
        params.append(now)
        params.append(word_id)

        query = f"""
            UPDATE words_es
            SET {', '.join(updates)}
            WHERE id = ?
        """
        rows_affected = await self._sqlite.update(query, tuple(params))

        if rows_affected == 0:
            return None

        # Retornar el registro actualizado
        select_query = """
            SELECT id, text, word_type, image_path, notes, created_at, updated_at
            FROM words_es
            WHERE id = ?
        """
        return await self._sqlite.fetch_one(select_query, (word_id,))

    async def delete(self, word_id: int) -> bool:
        """Elimina una palabra."""
        query = "DELETE FROM words_es WHERE id = ?"
        rows_affected = await self._sqlite.delete(query, (word_id,))
        return rows_affected > 0

    async def add_tag(self, word_id: int, tag_id: int) -> bool:
        """Añade un tag a una palabra."""
        query = """
            INSERT OR IGNORE INTO word_es_tags (word_es_id, tag_id)
            VALUES (?, ?)
        """
        try:
            await self._sqlite.insert(query, (word_id, tag_id))
            return True
        except Exception:
            return False

    async def remove_tag(self, word_id: int, tag_id: int) -> bool:
        """Elimina un tag de una palabra."""
        query = "DELETE FROM word_es_tags WHERE word_es_id = ? AND tag_id = ?"
        rows_affected = await self._sqlite.delete(query, (word_id, tag_id))
        return rows_affected > 0

    async def set_tags(self, word_id: int, tag_ids: list[int]) -> bool:
        """Reemplaza todos los tags de una palabra."""
        # Eliminar tags existentes
        delete_query = "DELETE FROM word_es_tags WHERE word_es_id = ?"
        await self._sqlite.delete(delete_query, (word_id,))

        # Añadir nuevos tags
        for tag_id in tag_ids:
            await self.add_tag(word_id, tag_id)

        return True

    async def add_relation(
        self,
        word_id_a: int,
        word_id_b: int,
        relation_type: str,
    ) -> bool:
        """Añade una relación entre dos palabras."""
        query = """
            INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
            VALUES (?, ?, ?)
        """
        try:
            await self._sqlite.insert(query, (word_id_a, word_id_b, relation_type))
            return True
        except Exception:
            return False

    async def remove_relation(self, word_id_a: int, word_id_b: int) -> bool:
        """Elimina una relación entre dos palabras."""
        query = """
            DELETE FROM word_es_relations
            WHERE (word_es_id_a = ? AND word_es_id_b = ?)
               OR (word_es_id_a = ? AND word_es_id_b = ?)
        """
        rows_affected = await self._sqlite.delete(
            query,
            (word_id_a, word_id_b, word_id_b, word_id_a)
        )
        return rows_affected > 0
