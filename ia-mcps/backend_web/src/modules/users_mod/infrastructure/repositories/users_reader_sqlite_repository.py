from contextlib import closing
from typing import Any, Self, final

from src.modules.shared.infrastructure.repositories.abstract_sqlite_repository import (
    AbstractSqliteRepository,
)
from src.modules.users_mod.infrastructure.repositories.users_sqlite_schema import (
    USERS_SCHEMA_STATEMENTS,
)


@final
class UsersReaderSqliteRepository(AbstractSqliteRepository):
    """Lectura de usuarios (datasource: SQLite, `db_ia_mcps`).

    Devuelve las columnas renombradas al vocabulario del módulo
    (`UserKeyEnum`), así que el nombre de la columna no sale de este fichero.
    """

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_schema_statements(self) -> list[str]:
        return USERS_SCHEMA_STATEMENTS

    def get_user_by_tg_id(self, user_tg_id: str, password_ttl_days: int) -> dict[str, Any]:
        """El usuario de un id de telegram, o {} si no hay ninguno.

        `is_password_fresh` lo calcula SQLite y no Python: `julianday` de una
        fecha vacía o corrupta es NULL, la comparación se vuelve NULL y el
        COALESCE la deja en 0, así que un `authenticated_at` ilegible caduca la
        ventana en vez de reventar al parsearlo. El plazo (los días) entra por
        parámetro: la regla de negocio vive en el caso de uso, aquí solo se
        aplica la aritmética.

        Devolver {} en vez de fallar es deliberado: quién es un usuario
        desconocido lo decide el caso de uso, no este repositorio.
        """
        sql = """
            SELECT
                id AS user_id,
                user_uuid,
                user_tg_id,
                user_name,
                user_role_id,
                user_pwd,
                is_enabled,
                authenticated_at,
                COALESCE(julianday('now') - julianday(authenticated_at) <= ?, 0) AS is_password_fresh
            FROM app_users
            WHERE user_tg_id = ?
            LIMIT 1
        """
        with closing(self._get_connection()) as connection:
            row = connection.execute(sql, [password_ttl_days, user_tg_id]).fetchone()
        return dict(row) if row else {}

    def get_user_profile_by_tg_id(self, user_tg_id: str) -> dict[str, Any]:
        """La fila entera de un usuario, o {} si ese id de telegram no existe.

        Hermana de `get_user_by_tg_id`, sin la cuenta de días: quien edita un
        usuario no necesita saber si su contraseña está fresca, y pedirle un
        plazo que no va a usar solo para reutilizar la consulta enturbiaría las
        dos.
        """
        sql = """
            SELECT
                id AS user_id,
                user_uuid,
                user_tg_id,
                user_name,
                user_role_id,
                user_pwd,
                is_enabled,
                authenticated_at
            FROM app_users
            WHERE user_tg_id = ?
            LIMIT 1
        """
        with closing(self._get_connection()) as connection:
            row = connection.execute(sql, [user_tg_id]).fetchone()
        return dict(row) if row else {}

    def get_user_id_by_tg_id(self, user_tg_id: str) -> int:
        """El id interno de un usuario, o 0 si ese id de telegram no existe."""
        sql = "SELECT id FROM app_users WHERE user_tg_id = ? LIMIT 1"
        with closing(self._get_connection()) as connection:
            row = connection.execute(sql, [user_tg_id]).fetchone()
        return int(row["id"]) if row else 0

    def has_user_by_tg_id(self, user_tg_id: str) -> bool:
        return self.get_user_id_by_tg_id(user_tg_id) > 0

    def get_users(self) -> list[dict[str, Any]]:
        """Listado completo SIN el hash de la contraseña: no se selecciona, así
        que no puede escaparse por un ResultDto."""
        sql = """
            SELECT
                id AS user_id,
                user_uuid,
                user_tg_id,
                user_name,
                user_role_id,
                is_enabled,
                authenticated_at,
                created_at,
                updated_at
            FROM app_users
            ORDER BY user_role_id, user_name, id
        """
        with closing(self._get_connection()) as connection:
            rows = connection.execute(sql).fetchall()
        return [dict(row) for row in rows]
