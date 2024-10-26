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
        for migration_file in self.__migrations_repository.get_migrations_files():
            self.__migrations_repository.run_from_file(migration_file)
