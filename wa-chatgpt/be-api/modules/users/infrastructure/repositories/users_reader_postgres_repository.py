from dataclasses import dataclass
from typing import final

from modules.shared.infrastructure.components.log import Log
from modules.shared.infrastructure.components.uuider import Uuider
from modules.users.domain.entities.user_entity import UserEntity
from modules.shared.infrastructure.components.date_timer import DateTimer
from modules.shared.infrastructure.repositories.abstract_postgres_repository import AbstractPostgresRepository

@final
@dataclass(frozen=False)
class UsersReaderPostgresRepository(AbstractPostgresRepository):

    @staticmethod
    def get_instance() -> "UsersReaderPostgresRepository":
        return UsersReaderPostgresRepository()

    def get_user_by_uuid(self, create_user_entity: UserEntity) -> UserEntity|None:
        sql = f"""
        SELECT *
        FROM app_users 
        WHERE 1=1 
        AND user_uuid = '{create_user_entity.user_uuid}'
        """
        Log.log_sql(sql, "get_user_by_uuid")
        result = self._query(sql)
        if not result:
            return None

        created_at = DateTimer.get_instance().get_datetime_to_ymd_his(
            result[0].get("created_at")
        )

        return UserEntity.from_primitives(
            id=result[0].get("id"),
            user_uuid=result[0].get("user_uuid"),
            user_name=result[0].get("user_name"),
            user_login=result[0].get("user_login"),
            user_password=result[0].get("user_password"),
            user_email=result[0].get("user_email"),
            user_code=result[0].get("user_code"),
            created_at=created_at
        )

    def get_user_id_by_user_email(self, create_user_entity: UserEntity) -> UserEntity | None:
        user_email = create_user_entity.user_email
        user_email = self._get_escaped_sql_string(user_email)
        sql = f"""
        SELECT id
        FROM app_users 
        WHERE 1=1 
        AND user_email = '{user_email}'
        """
        Log.log_sql(sql, "get_user_id_by_user_email")
        result = self._query(sql)
        if not result:
            return None

        return UserEntity.from_primitives_dic({"id": result[0].get("id")})

    def get_user_id_by_user_login(self, create_user_entity: UserEntity) -> UserEntity | None:
        user_login = create_user_entity.user_login
        user_login = self._get_escaped_sql_string(user_login)
        sql = f"""
        SELECT id
        FROM app_users 
        WHERE 1=1 
        AND user_login = '{user_login}'
        """
        Log.log_sql(sql, "get_user_id_by_user_login")
        result = self._query(sql)
        if not result:
            return None

        return UserEntity.from_primitives_dic({"id": result[0].get("id")})
