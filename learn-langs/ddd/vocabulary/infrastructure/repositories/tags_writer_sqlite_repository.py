"""Repositorio de escritura para tags."""

from datetime import datetime
from typing import final, Self

from ddd.shared.infrastructure.repositories import AbstractSqliteRepository
from ddd.vocabulary.domain.entities import TagEntity


@final
class TagsWriterSqliteRepository(AbstractSqliteRepository):
    """Repositorio de escritura para tags."""

    def __init__(self) -> None:
        super().__init__()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def create(self, tag_entity: TagEntity) -> int:
        """Crea un nuevo tag y retorna el ID generado."""
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        return await self._insert_into("tags", {
            "name": tag_entity.name.strip(),
            "color": tag_entity.color,
            "created_at": now,
        })

    async def update(self, tag_entity: TagEntity) -> bool:
        """Actualiza un tag existente."""
        rows_affected = await self._update_where(
            "tags",
            {"name": tag_entity.name.strip(), "color": tag_entity.color},
            "id = ?",
            (tag_entity.id,),
        )
        return rows_affected > 0

    async def delete(self, tag_entity: TagEntity) -> bool:
        """Elimina un tag."""
        rows_affected = await self._delete_where("tags", "id = ?", (tag_entity.id,))
        return rows_affected > 0
