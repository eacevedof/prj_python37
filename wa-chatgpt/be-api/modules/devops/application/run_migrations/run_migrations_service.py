import os
from dataclasses import dataclass
from typing import final

from modules.devops.infrastructure.repositories.migrations_postgres_repository import MigrationsPostgresRepository

@final
@dataclass
class RunMigrationsService:
    __migrations_repository: MigrationsPostgresRepository

    @staticmethod
    def get_instance() -> "RunMigrationsService":
        return RunMigrationsService(
            MigrationsPostgresRepository.get_instance()
        )

    def invoke(self) -> None:
        self.__create_migrations_table()
        # self.__run_migrations()

    def __create_migrations_table(self) -> None:
        if self.__migrations_repository.does_migrations_table_exist():
            return
        self.__migrations_repository.create_migrations_table()

    def __run_migrations(self) -> None:
        for migration_file in self.__get_migration_files():
            self.__run_migration(migration_file)

    def __get_migration_files(self) -> list[str]:
        return os.listdir(self.__migrations_folder)

    def __run_migration(self, migration_file: str) -> None:
        migration_file_path = f"{self.__migrations_folder}/{migration_file}"
        sql = self.__get_migration_file_content(migration_file_path)
        self.__migrations_repository.query(sql)