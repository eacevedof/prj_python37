from contextlib import closing
from typing import Any, Self, final

from src.modules.shared.infrastructure.repositories.abstract_sqlite_repository import (
    AbstractSqliteRepository,
)
from src.modules.emt_mod.infrastructure.repositories.favorite_stops_sqlite_schema import (
    FAVORITE_STOPS_SCHEMA_STATEMENTS,
)


@final
class FavoriteStopsReaderSqliteRepository(AbstractSqliteRepository):
    """Lectura de las paradas favoritas (datasource: SQLite, `db_ia_mcps`).

    TODA consulta lleva el `user_id` en el WHERE. No es defensa duplicada: el
    caso de uso decide de quién son los datos y aquí se hace cumplir, así que
    una consulta sin dueño no se puede ni escribir por descuido.
    """

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_schema_statements(self) -> list[str]:
        return FAVORITE_STOPS_SCHEMA_STATEMENTS

    def get_favorite_stops_by_user_id(self, user_id: int) -> list[dict[str, Any]]:
        sql = """
            SELECT stop_nr, stop_description, created_at, updated_at
            FROM app_mcp_stops
            WHERE user_id = ?
            ORDER BY stop_nr
        """
        with closing(self._get_connection()) as connection:
            rows = connection.execute(sql, [user_id]).fetchall()
        return [dict(row) for row in rows]

    def get_favorite_stop(self, user_id: int, stop_nr: str) -> dict[str, Any]:
        """Una parada favorita concreta, o {} si ese usuario no la tiene."""
        sql = """
            SELECT stop_nr, stop_description, created_at, updated_at
            FROM app_mcp_stops
            WHERE user_id = ? AND stop_nr = ?
            LIMIT 1
        """
        with closing(self._get_connection()) as connection:
            row = connection.execute(sql, [user_id, stop_nr]).fetchone()
        return dict(row) if row else {}

    def has_favorite_stop(self, user_id: int, stop_nr: str) -> bool:
        return bool(self.get_favorite_stop(user_id, stop_nr))
