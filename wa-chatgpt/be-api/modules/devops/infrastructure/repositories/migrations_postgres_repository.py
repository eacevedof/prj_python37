from dataclasses import dataclass
from typing import final

from modules.shared.infrastructure.repositories.abstract_postgres_repository import AbstractPostgresRepository

@final
@dataclass(frozen=True)
class MigrationsPostgresRepository(AbstractPostgresRepository):

    @staticmethod
    def get_instance() -> "MigrationsPostgresRepository":
        return MigrationsPostgresRepository()

    def does_table_exist(self, table_name) -> bool:
        sql = f"""
        SELECT EXISTS (
            SELECT 1 
            FROM information_schema.tables 
            WHERE table_schema = 'public' 
            AND table_name = '{table_name}'
        );
        """
        results = self._query(sql)
        if not results:
            return False
        result = results[0].get("exists", "f")
        return result == "t"