from typing import Any, Self, final

from src.modules.shared.infrastructure.repositories.abstract_sqlite_repository import AbstractSqliteRepository


@final
class {{Modulo}}ReaderSqliteRepository(AbstractSqliteRepository):
    """Lectura de {{entidad}}s.

    REGLAS: cero try/except, cero reglas de negocio, devuelve primitivos,
    siempre `?` para los valores, siempre `delete_date IS NULL`.
    """

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_by_id(self, {{entidad}}_id: int) -> dict[str, Any] | None:
        cursor = self._get_connection().cursor()
        cursor.execute(
            """
            SELECT id, <columnas>
            FROM {{tabla}}
            WHERE id = ? AND delete_date IS NULL
            LIMIT 1
            """,
            ({{entidad}}_id,),
        )
        row = cursor.fetchone()
        return dict(row) if row else None
