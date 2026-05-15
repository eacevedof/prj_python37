"""Repositorio de escritura para word_groups."""

from typing import final, Self

from ddd.shared.infrastructure.repositories import AbstractSqliteRepository
from ddd.vocabulary.domain.entities import WordGroupEntity


@final
class WordGroupsWriterSqliteRepository(AbstractSqliteRepository):
    """Repositorio para escritura de grupos de palabras."""

    _instance: "WordGroupsWriterSqliteRepository | None" = None

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def create(self, entity: WordGroupEntity) -> dict:
        """
        Crea un nuevo grupo de palabras.

        Args:
            entity: Entidad WordGroupEntity.

        Returns:
            Diccionario con datos del grupo creado.
        """
        query = """
            INSERT INTO word_groups (title, description, created_at, updated_at)
            VALUES (?, ?, datetime('now'), datetime('now'))
        """

        async with self._get_connection() as conn:
            cursor = await conn.execute(
                query,
                (entity.title, entity.description),
            )
            await conn.commit()

            group_id = cursor.lastrowid

            return {
                "id": group_id,
                "title": entity.title,
                "description": entity.description,
            }

    async def update(self, group_id: int, entity: WordGroupEntity) -> dict:
        """
        Actualiza un grupo existente.

        Args:
            group_id: ID del grupo a actualizar.
            entity: Entidad WordGroupEntity con datos actualizados.

        Returns:
            Diccionario con datos del grupo actualizado.
        """
        query = """
            UPDATE word_groups
            SET title = ?,
                description = ?,
                updated_at = datetime('now')
            WHERE id = ?
        """

        async with self._get_connection() as conn:
            await conn.execute(
                query,
                (entity.title, entity.description, group_id),
            )
            await conn.commit()

            return {
                "id": group_id,
                "title": entity.title,
                "description": entity.description,
            }

    async def delete(self, group_id: int) -> bool:
        """
        Elimina un grupo de palabras.

        Args:
            group_id: ID del grupo a eliminar.

        Returns:
            True si se eliminó correctamente.
        """
        query = "DELETE FROM word_groups WHERE id = ?"

        async with self._get_connection() as conn:
            await conn.execute(query, (group_id,))
            await conn.commit()
            return True

    async def associate_word(self, word_id: int, group_id: int) -> bool:
        """
        Asocia una palabra con un grupo.

        Args:
            word_id: ID de la palabra.
            group_id: ID del grupo.

        Returns:
            True si se asoció correctamente.
        """
        query = """
            INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
            VALUES (?, ?)
        """

        async with self._get_connection() as conn:
            await conn.execute(query, (word_id, group_id))
            await conn.commit()
            return True

    async def disassociate_word(self, word_id: int, group_id: int) -> bool:
        """
        Desasocia una palabra de un grupo.

        Args:
            word_id: ID de la palabra.
            group_id: ID del grupo.

        Returns:
            True si se desasocio correctamente.
        """
        query = """
            DELETE FROM word_es_groups
            WHERE word_es_id = ? AND group_id = ?
        """

        async with self._get_connection() as conn:
            await conn.execute(query, (word_id, group_id))
            await conn.commit()
            return True

    async def clear_word_groups(self, word_id: int) -> bool:
        """
        Elimina todas las asociaciones de grupos de una palabra.

        Args:
            word_id: ID de la palabra.

        Returns:
            True si se eliminaron correctamente.
        """
        query = "DELETE FROM word_es_groups WHERE word_es_id = ?"

        async with self._get_connection() as conn:
            await conn.execute(query, (word_id,))
            await conn.commit()
            return True

    async def set_word_groups(self, word_id: int, group_ids: list[int]) -> bool:
        """
        Establece los grupos de una palabra (reemplaza los existentes).

        Args:
            word_id: ID de la palabra.
            group_ids: Lista de IDs de grupos.

        Returns:
            True si se establecieron correctamente.
        """
        async with self._get_connection() as conn:
            # Eliminar grupos existentes
            await conn.execute(
                "DELETE FROM word_es_groups WHERE word_es_id = ?",
                (word_id,),
            )

            # Insertar nuevos grupos
            if group_ids:
                for group_id in group_ids:
                    await conn.execute(
                        "INSERT INTO word_es_groups (word_es_id, group_id) VALUES (?, ?)",
                        (word_id, group_id),
                    )

            await conn.commit()
            return True
