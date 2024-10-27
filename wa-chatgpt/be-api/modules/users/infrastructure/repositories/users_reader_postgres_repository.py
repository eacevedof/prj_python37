from dataclasses import dataclass
from typing import final

from modules.shared.infrastructure.components.log import Log
from modules.shared.infrastructure.components.uuider import Uuider
from modules.users.domain.entities.user_entity import UserEntity
from modules.shared.infrastructure.components.date_timer import DateTimer
from modules.shared.infrastructure.repositories.abstract_postgres_repository import AbstractPostgresRepository

@final
@dataclass(frozen=True)
class UsersReaderPostgresRepository(AbstractPostgresRepository):

    @staticmethod
    def get_instance() -> "UsersReaderPostgresRepository":
        return UsersReaderPostgresRepository()

    def get_user_by_uuid(self, create_user_entity: UserEntity) -> UserEntity|None:
        sql = f"""
        SELECT *
        FROM app_users 
        WHERE 1
        AND user_uuid = '{create_user_entity.user_uuid}'
        """
        Log.log_sql(sql, "get_user_by_uuid")
        result = self._query(sql)
        if (len(result) == 0):
            return None
        return UserEntity.from_primitives(
            user_uuid=result[0][0],
            user_name=result[0][1],
            user_password=result[0][2],
            user_email=result[0][3],
            user_code=result[0][4]
        )
