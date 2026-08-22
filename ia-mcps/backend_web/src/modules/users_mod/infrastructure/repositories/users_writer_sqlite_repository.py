from contextlib import closing
from typing import Any, Self, final

from src.modules.shared.infrastructure.repositories.abstract_sqlite_repository import (
    AbstractSqliteRepository,
)
from src.modules.users_mod.domain.enums.user_key_enum import UserKeyEnum
from src.modules.users_mod.infrastructure.repositories.users_sqlite_schema import (
    USERS_SCHEMA_STATEMENTS,
)


@final
class UsersWriterSqliteRepository(AbstractSqliteRepository):
    """Escritura de usuarios (datasource: SQLite, `db_ia_mcps`).

    Las marcas de tiempo las pone SQLite con `datetime('now')` (UTC): así todas
    las filas se fechan con el mismo reloj que luego las compara en
    `julianday`, y no con el del proceso.
    """

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_schema_statements(self) -> list[str]:
        return USERS_SCHEMA_STATEMENTS

    def create_user(self, primitives: dict[str, Any]) -> int:
        """Da de alta un usuario y devuelve su id interno.

        `user_pwd` llega YA hasheado desde el caso de uso: aquí no se sabe qué es
        una contraseña.
        """
        sql = """
            INSERT INTO app_users (
                user_uuid, user_role_id, user_tg_id, user_name, user_pwd,
                is_enabled, authenticated_at, created_at, updated_at
            )
            VALUES (?, ?, ?, ?, ?, ?, '', datetime('now'), datetime('now'))
        """
        with closing(self._get_connection()) as connection:
            with connection:
                cursor = connection.execute(
                    sql,
                    [
                        primitives[UserKeyEnum.USER_UUID],
                        primitives[UserKeyEnum.USER_ROLE_ID],
                        primitives[UserKeyEnum.USER_TG_ID],
                        primitives[UserKeyEnum.USER_NAME],
                        primitives[UserKeyEnum.USER_PWD],
                        primitives[UserKeyEnum.IS_ENABLED],
                    ],
                )
        return int(cursor.lastrowid or 0)

    def update_authenticated_at(self, user_id: int) -> None:
        """Reabre la ventana de 7 días: se llama solo cuando la contraseña que
        acaba de llegar es correcta."""
        sql = """
            UPDATE app_users
            SET authenticated_at = datetime('now'), updated_at = datetime('now')
            WHERE id = ?
        """
        with closing(self._get_connection()) as connection:
            with connection:
                connection.execute(sql, [user_id])
