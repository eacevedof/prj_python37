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

    def invoke(self) -> list[str]:
        self.__create_migrations_table()
        return self.__migrations_repository.run_migrations()

    def __create_migrations_table(self) -> None:
        if self.__migrations_repository.does_migrations_table_exist():
            return
        self.__migrations_repository.create_migrations_table()

