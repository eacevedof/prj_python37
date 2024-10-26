import os
from dataclasses import dataclass
from typing import final

from config.paths import PATH_DATABASE_FOLDER
from modules.devops.infrastructure.repositories.migrations_postgres_repository import MigrationsPostgresRepository

@final
@dataclass
class RunMigrationsService:
    __migrations_folder: str
    __migrations_table_file: str
    __migrations_repository: MigrationsPostgresRepository

    @staticmethod
    def get_instance() -> "RunMigrationsService":
        return RunMigrationsService()

    def __post_init__(self):
        __migrations_folder = f"{PATH_DATABASE_FOLDER}/migrations"
        __migrations_table_file = "00000_create_table_migrations.sql"
        __migrations_repository = MigrationsPostgresRepository.get_instance()

    def invoke(self) -> None:
        self.__create_migrations_table()
        self.__run_migrations()

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