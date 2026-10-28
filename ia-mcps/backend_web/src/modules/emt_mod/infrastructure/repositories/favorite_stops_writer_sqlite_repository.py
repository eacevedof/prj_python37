from contextlib import closing
from typing import Self, final

from src.modules.shared.infrastructure.repositories.abstract_sqlite_repository import (
    AbstractSqliteRepository,
)
from src.modules.emt_mod.infrastructure.repositories.favorite_stops_sqlite_schema import (
    FAVORITE_STOPS_SCHEMA_STATEMENTS,
)


@final
class FavoriteStopsWriterSqliteRepository(AbstractSqliteRepository):
    """Escritura de las paradas favoritas (datasource: SQLite, `db_ia_mcps`).

    Igual que en lectura, el `user_id` va SIEMPRE en el WHERE: un UPDATE o un
    DELETE no pueden alcanzar la fila de otro aunque acierten el número de
    parada. Las fechas las pone SQLite (`datetime('now')`, UTC).
    """

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_schema_statements(self) -> list[str]:
        return FAVORITE_STOPS_SCHEMA_STATEMENTS

    def create_favorite_stop(self, user_id: int, stop_nr: str, stop_description: str) -> int:
        sql = """
            INSERT INTO app_mcp_stops (user_id, stop_nr, stop_description, created_at, updated_at)
            VALUES (?, ?, ?, datetime('now'), datetime('now'))
        """
        with closing(self._get_connection()) as connection:
            with connection:
                cursor = connection.execute(sql, [user_id, stop_nr, stop_description])
        return int(cursor.lastrowid or 0)

    def update_favorite_stop(self, user_id: int, stop_nr: str, stop_description: str) -> int:
        """Devuelve las filas afectadas: 0 significa que ese usuario no tenía
        esa parada (y el caso de uso ya lo ha comprobado antes)."""
        sql = """
            UPDATE app_mcp_stops
            SET stop_description = ?, updated_at = datetime('now')
            WHERE user_id = ? AND stop_nr = ?
        """
        with closing(self._get_connection()) as connection:
            with connection:
                cursor = connection.execute(sql, [stop_description, user_id, stop_nr])
        return int(cursor.rowcount)

    def delete_favorite_stop(self, user_id: int, stop_nr: str) -> int:
        sql = "DELETE FROM app_mcp_stops WHERE user_id = ? AND stop_nr = ?"
        with closing(self._get_connection()) as connection:
            with connection:
                cursor = connection.execute(sql, [user_id, stop_nr])
        return int(cursor.rowcount)
