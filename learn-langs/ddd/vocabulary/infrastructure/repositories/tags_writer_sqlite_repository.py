from datetime import datetime
from typing import final, Self

from ddd.shared.infrastructure.repositories.sqlite_connection import SqliteConnection


@final
class TagsWriterSqliteRepository:
    """Repositorio de escritura para tags."""

    _sqlite: SqliteConnection

    def __init__(self) -> None:
        self._sqlite = SqliteConnection.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def create(self, name: str, color: str = "#6B7280") -> dict:
        """Crea un nuevo tag."""
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        query = "INSERT INTO tags (name, color, created_at) VALUES (?, ?, ?)"
        tag_id = await self._sqlite.insert(query, (name.strip(), color, now))

        return {
            "id": tag_id,
            "name": name.strip(),
            "color": color,
            "created_at": now,
        }

    async def update(
        self,
        tag_id: int,
        name: str | None = None,
        color: str | None = None,
    ) -> dict | None:
        """Actualiza un tag existente."""
        updates: list[str] = []
        params: list = []

        if name is not None:
            updates.append("name = ?")
            params.append(name.strip())

        if color is not None:
            updates.append("color = ?")
            params.append(color)

        if not updates:
            return None

        params.append(tag_id)
        query = f"UPDATE tags SET {', '.join(updates)} WHERE id = ?"
        rows_affected = await self._sqlite.update(query, tuple(params))

        if rows_affected == 0:
            return None

        return await self._sqlite.fetch_one(
            "SELECT id, name, color, created_at FROM tags WHERE id = ?",
            (tag_id,)
        )

    async def delete(self, tag_id: int) -> bool:
        """Elimina un tag."""
        query = "DELETE FROM tags WHERE id = ?"
        rows_affected = await self._sqlite.delete(query, (tag_id,))
        return rows_affected > 0
