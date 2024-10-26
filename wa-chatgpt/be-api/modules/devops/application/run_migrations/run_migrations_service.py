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

    def __post_init__(self):
        __migrations_folder = f"{PATH_DATABASE_FOLDER}/migrations"
        __migrations_table_file = "00000_create_table_migrations.sql"
        __migrations_repository = MigrationsPostgresRepository.get_instance()

    def invoke(self) -> None:
        pass

    def __create_migrations_table(self) -> None:
        if self.__migrations_repository.does_table_exist("migrations"):
            return
