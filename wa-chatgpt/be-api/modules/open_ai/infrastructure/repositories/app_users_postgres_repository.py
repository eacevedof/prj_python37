from dataclasses import dataclass
from typing import final

from modules.shared.infrastructure.repositories.abstract_postgres_repository import AbstractPostgresRepository

@final
@dataclass(frozen=True)
class AppUsersPostgresRepository(AbstractPostgresRepository):

    @staticmethod
    def get_instance() -> "AppUsersPostgresRepository":
        return AppUsersPostgresRepository()

    def get_all_users(self) -> list[dict]:
        sql = f"""
        SELECT * 
        FROM app_users 
        WHERE 1
        """
        results = self._query(sql)
        if not results:
            return []
        return results