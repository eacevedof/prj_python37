import os
from dataclasses import dataclass
from typing import final

from config.paths import PATH_DATABASE_FOLDER

from modules.shared.infrastructure.components.log import Log
from modules.shared.infrastructure.components.date_timer import DateTimer
from modules.shared.infrastructure.repositories.abstract_postgres_repository import AbstractPostgresRepository

@final
@dataclass(frozen=False)
class MigrationsPostgresRepository(AbstractPostgresRepository):

    __CREATE_MIGRATION_TABLE_FILE = "00000_create_table_migrations.sql"
    __MIGRATIONS_TABLE_NAME = "migrations"
    __MIGRATIONS_FOLDER = f"{PATH_DATABASE_FOLDER}/migrations"
    __MIGRATIONS_FILE = f"{__MIGRATIONS_FOLDER}/{__CREATE_MIGRATION_TABLE_FILE}"

    __date_timer: DateTimer

    @staticmethod
    def get_instance() -> "MigrationsPostgresRepository":
        return MigrationsPostgresRepository(
            DateTimer.get_instance()
        )

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

        return results[0]["exists"]

    def does_migrations_table_exist(self) -> bool:
        return self.does_table_exist(self.__MIGRATIONS_TABLE_NAME)

    def create_migrations_table(self) -> None:
        if self.does_migrations_table_exist():
            return
        sql = self.__get_migration_file_content()
        self._command(sql)

    def __get_migration_file_content(self) -> str:
        with open(self.__MIGRATIONS_FILE, "r") as file:
            return file.read()

    def run_migrations(self) -> list[str]:
        files = os.listdir(self.__MIGRATIONS_FOLDER)
        files = sorted(files)
        batch_number = self.__get_last_migration_batch() or 1
        run_migrations = self.__get_all_migrations()

        results = []
        for sql_file in files:
            if not sql_file.endswith(".sql"):
                continue
            if sql_file == self.__CREATE_MIGRATION_TABLE_FILE:
                continue
            if sql_file in run_migrations:
                continue
            sql = self.__get_file_content(sql_file)
            Log.log_sql(sql, sql_file)
            self._command(sql)
            self.__save_migration(sql_file, batch_number)
            result = f"[{self.__date_timer.get_now_ymd_his()}] {sql_file}"
            results.append(result)

        return results


    def __get_file_content(self, file) -> str:
        with open(f"{self.__MIGRATIONS_FOLDER}/{file}", "r") as file:
            return file.read()

    def __save_migration(self, migration_name: str, batch_number: int) -> None:
        sql = f"""
        INSERT INTO {self.__MIGRATIONS_TABLE_NAME} (migration, batch) VALUES ('{migration_name}', {batch_number});
        """
        self._command(sql)

    def __get_last_migration_batch(self) -> None | int:
        sql = f"""
        SELECT batch FROM {self.__MIGRATIONS_TABLE_NAME} ORDER BY id DESC LIMIT 1;
        """
        results = self._query(sql)
        if not results:
            return None
        return int(results[0]["batch"])

    def __get_all_migrations(self) -> list[str]:
        sql = f"""
        SELECT migration FROM {self.__MIGRATIONS_TABLE_NAME} ORDER BY id ASC;
        """
        results = self._query(sql)
        return [result.get("migration") for result in results]