from typing import Self, final

from src.modules.shared.infrastructure.repositories.abstract_sqlite_repository import AbstractSqliteRepository


@final
class {{Modulo}}WriterSqliteRepository(AbstractSqliteRepository):
    """Escritura de {{entidad}}s."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def create(self, <campos>) -> int:
        connection = self._get_connection()
        cursor = connection.cursor()
        cursor.execute(
            """
            INSERT INTO {{tabla}} (<columnas>)
            VALUES (?, ?)
            """,
            (<valores>,),
        )
        new_id = int(cursor.lastrowid or 0)
        connection.commit()
        return new_id

    def soft_delete(self, {{entidad}}_id: int) -> bool:
        """Borrado LOGICO: marca la fecha, no elimina la fila."""
        connection = self._get_connection()
        cursor = connection.cursor()
        cursor.execute(
            """
            UPDATE {{tabla}}
            SET delete_date = CURRENT_TIMESTAMP
            WHERE id = ? AND delete_date IS NULL
            """,
            ({{entidad}}_id,),
        )
        connection.commit()
        return cursor.rowcount > 0
