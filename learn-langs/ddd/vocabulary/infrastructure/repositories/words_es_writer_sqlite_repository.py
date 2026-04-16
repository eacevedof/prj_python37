from datetime import datetime
from typing import final, Self

from ddd.shared.infrastructure.components.sqlite_connector import SqliteConnector
from ddd.vocabulary.domain.entities import WordEsEntity


@final
class WordsEsWriterSqliteRepository:
    """Repositorio de escritura para palabras en español."""

    _sqlite: SqliteConnector

    def __init__(self) -> None:
        self._sqlite = SqliteConnector.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def create(self, word_es_entity: WordEsEntity) -> int:
        """Crea una nueva palabra y retorna el ID generado."""
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        query = """
            INSERT INTO words_es (text, word_type, image_path, notes, created_at, updated_at)
            VALUES (?, ?, ?, ?, ?, ?)
        """
        word_id = await self._sqlite.insert(
            query,
            (
                word_es_entity.text.strip(),
                word_es_entity.word_type.value,
                word_es_entity.image_path,
                word_es_entity.notes,
                now,
                now,
            ),
        )

        return word_id

    async def update(self, word_es_entity: WordEsEntity) -> bool:
        """Actualiza una palabra existente."""
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        query = """
            UPDATE words_es
            SET text = ?, word_type = ?, image_path = ?, notes = ?, updated_at = ?
            WHERE id = ?
        """
        rows_affected = await self._sqlite.update(
            query,
            (
                word_es_entity.text.strip(),
                word_es_entity.word_type.value,
                word_es_entity.image_path,
                word_es_entity.notes,
                now,
                word_es_entity.id,
            ),
        )

        return rows_affected > 0

    async def delete(self, word_es_entity: WordEsEntity) -> bool:
        """Elimina una palabra."""
        query = "DELETE FROM words_es WHERE id = ?"
        rows_affected = await self._sqlite.delete(query, (word_es_entity.id,))
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
        delete_query = "DELETE FROM word_es_tags WHERE word_es_id = ?"
        await self._sqlite.delete(delete_query, (word_id,))

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
            (word_id_a, word_id_b, word_id_b, word_id_a),
        )
        return rows_affected > 0
