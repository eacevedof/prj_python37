from dataclasses import dataclass
from typing import final

from config.paths import PATH_DATABASE_FOLDER

from modules.shared.infrastructure.repositories.abstract_postgres_repository import AbstractPostgresRepository

@final
@dataclass(frozen=True)
class MigrationsPostgresRepository(AbstractPostgresRepository):

    __MIGRATIONS_TABLE_NAME = "migrations"
    __MIGRATIONS_FILE = f"{PATH_DATABASE_FOLDER}/migrations/00000_create_table_migrations.sql"

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

        return results[0][0]

    def does_migrations_table_exist(self) -> bool:
        return self.does_table_exist(self.__MIGRATIONS_TABLE_NAME)

    def create_migrations_table(self) -> None:
        sql = self.__get_migration_file_content()
        self._execute(sql)

    def __get_migration_file_content(self) -> str:
        with open(self.__MIGRATIONS_FILE, "r") as file:
            return file.read()