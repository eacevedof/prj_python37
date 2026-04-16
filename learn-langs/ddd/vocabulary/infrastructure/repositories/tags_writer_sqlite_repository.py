from datetime import datetime
from typing import final, Self

from ddd.shared.infrastructure.components.sqlite_connector import SqliteConnector
from ddd.vocabulary.domain.entities import TagEntity


@final
class TagsWriterSqliteRepository:
    """Repositorio de escritura para tags."""

    _sqlite: SqliteConnector

    def __init__(self) -> None:
        self._sqlite = SqliteConnector.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def create(self, tag_entity: TagEntity) -> int:
        """Crea un nuevo tag y retorna el ID generado."""
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        query = "INSERT INTO tags (name, color, created_at) VALUES (?, ?, ?)"
        tag_id = await self._sqlite.insert(
            query,
            (tag_entity.name.strip(), tag_entity.color, now),
        )

        return tag_id

    async def update(self, tag_entity: TagEntity) -> bool:
        """Actualiza un tag existente."""
        query = "UPDATE tags SET name = ?, color = ? WHERE id = ?"
        rows_affected = await self._sqlite.update(
            query,
            (tag_entity.name.strip(), tag_entity.color, tag_entity.id),
        )
        return rows_affected > 0

    async def delete(self, tag_entity: TagEntity) -> bool:
        """Elimina un tag."""
        query = "DELETE FROM tags WHERE id = ?"
        rows_affected = await self._sqlite.delete(query, (tag_entity.id,))
        return rows_affected > 0
