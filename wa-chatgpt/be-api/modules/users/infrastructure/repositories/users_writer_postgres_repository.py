from dataclasses import dataclass
from typing import final

from modules.shared.infrastructure.components.log import Log
from modules.shared.infrastructure.components.uuider import Uuider
from modules.users.domain.entities.user_entity import UserEntity
from modules.shared.infrastructure.components.date_timer import DateTimer
from modules.shared.infrastructure.repositories.abstract_postgres_repository import AbstractPostgresRepository

@final
@dataclass(frozen=True)
class UsersWriterPostgresRepository(AbstractPostgresRepository):

    __date_timer: DateTimer
    __uuider: Uuider

    @staticmethod
    def get_instance() -> "UsersWriterPostgresRepository":
        return UsersWriterPostgresRepository(
            DateTimer.get_instance(),
            Uuider.get_instance()
        )

    def create_user(self, create_user_entity: UserEntity) -> None:
        user_uuid = create_user_entity.user_uuid
        user_name = create_user_entity.user_name
        user_login = create_user_entity.user_login
        user_password = create_user_entity.user_password
        user_email = create_user_entity.user_email
        user_code = create_user_entity.user_code
        created_at = self.__date_timer.get_now_ymd_his()
        sql = f"""
        INSERT INTO app_users 
        (user_uuid, user_name, user_login, user_password, user_email, user_code, user_is_enabled, created_at)
        VALUES 
        ('{user_uuid}', '{user_name}', '{user_login}' , '{user_password}', '{user_email}', '{user_code}', 1, '{created_at}');
        """
        Log.log_sql(sql, "create_user")
        self._command(sql)