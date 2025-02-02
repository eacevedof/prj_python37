from dataclasses import dataclass
from typing import final

from modules.shared.infrastructure.components.log import Log
from modules.shared.infrastructure.components.uuider import Uuider
from modules.shared.infrastructure.components.date_timer import DateTimer
from modules.shared.infrastructure.repositories.abstract_mysql_repository import AbstractMysqlRepository

@final
@dataclass(frozen=False)
class LcMysqlRepository(AbstractMysqlRepository):

    __date_timer: DateTimer
    __uuider: Uuider

    @staticmethod
    def get_instance() -> "LcMysqlRepository":
        lc_mysql_repository = LcMysqlRepository(
            DateTimer.get_instance(),
            Uuider.get_instance()
        )
        lc_mysql_repository.set_context()
        return lc_mysql_repository


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


