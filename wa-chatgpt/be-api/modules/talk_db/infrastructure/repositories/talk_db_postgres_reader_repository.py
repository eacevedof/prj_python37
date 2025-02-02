from dataclasses import dataclass
from typing import final

from modules.shared.infrastructure.components.log import Log
from modules.shared.infrastructure.components.date_timer import DateTimer
from modules.shared.infrastructure.repositories.abstract_postgres_repository import AbstractPostgresRepository
from modules.talk_db.domain.entities.talk_db_entity import TalkDbEntity

@final
@dataclass(frozen=False)
class TalkDbPostgresReaderRepository(AbstractPostgresRepository):

    @staticmethod
    def get_instance() -> "TalkDbPostgresReaderRepository":
        return TalkDbPostgresReaderRepository()

    def get_user_by_uuid(self, talk_db_entity: TalkDbEntity) -> TalkDbEntity|None:
        sql = f"""
        SELECT *
        FROM app_users 
        WHERE 1=1 
        AND user_uuid = '{talk_db_entity.user_uuid}'
        """
        Log.log_sql(sql, "get_user_by_uuid")
        result = self._query(sql)
        if not result:
            return None

        created_at = DateTimer.get_instance().get_datetime_to_ymd_his(
            result[0].get("created_at")
        )

        return TalkDbEntity.from_primitives(
            id=result[0].get("id"),
            user_uuid=result[0].get("user_uuid"),
            user_name=result[0].get("user_name"),
            user_login=result[0].get("user_login"),
            user_password=result[0].get("user_password"),
            user_email=result[0].get("user_email"),
            user_code=result[0].get("user_code"),
            created_at=created_at
        )
