from dataclasses import dataclass
from typing import final

from modules.shared.infrastructure.components.log import Log
from modules.shared.infrastructure.components.uuider import Uuider
from modules.shared.infrastructure.components.date_timer import DateTimer
from modules.shared.infrastructure.repositories.abstract_mysql_repository import AbstractMysqlRepository
from modules.users.domain.entities.user_entity import UserEntity

@final
@dataclass(frozen=False)
class LcMysqlRepository(AbstractMysqlRepository):

    __date_timer: DateTimer
    __uuider: Uuider

    @staticmethod
    def get_instance() -> "LcMysqlRepository":
        return LcMysqlRepository(
            DateTimer.get_instance(),
            Uuider.get_instance()
        )

    def get_sum_population(self) -> int:
        sql = """
        SELECT 
            SUM(population) as sum_population 
        FROM Country
        WHERE 1
        AND Continent = 'Asia'
        """
        Log.log_sql(sql, "get_sum_population")
        result = self._query(sql)
        return result[0].get("sum_population")

    def get_connection_string(self) -> str:
        return self._get_connection_string()


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


