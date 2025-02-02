from dataclasses import dataclass
from typing import final

from modules.shared.infrastructure.components.log import Log
from modules.shared.infrastructure.components.uuider import Uuider
from modules.shared.infrastructure.components.date_timer import DateTimer
from modules.shared.infrastructure.repositories.abstract_mysql_repository import AbstractMysqlRepository

@final
@dataclass(frozen=False)
class TpMysqlRepository(AbstractMysqlRepository):

    __date_timer: DateTimer
    __uuider: Uuider

    @staticmethod
    def get_instance() -> "TpMysqlRepository":
        lc_mysql_repository = TpMysqlRepository(
            DateTimer.get_instance(),
            Uuider.get_instance()
        )
        lc_mysql_repository.set_context()
        return lc_mysql_repository


    def query(self, sql: str) -> list[dict[str, any]]:
        Log.log_sql(sql, "query")
        return self._query(sql)




