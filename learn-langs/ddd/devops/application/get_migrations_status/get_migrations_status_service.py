from pathlib import Path
from typing import Self, final

from ddd.devops.domain.exceptions.devops_exception import DevopsException
from ddd.devops.infrastructure.repositories.migration_files_reader_file_repository import (
    MigrationFilesReaderFileRepository,
)
from ddd.devops.infrastructure.repositories.migrations_reader_sqlite_repository import (
    MigrationsReaderSqliteRepository,
)
from ddd.devops.infrastructure.repositories.migrations_writer_sqlite_repository import (
    MigrationsWriterSqliteRepository,
)
from ddd.devops.application.get_migrations_status.get_migrations_status_dto import GetMigrationsStatusDto
from ddd.devops.application.get_migrations_status.get_migrations_status_result_dto import (
    GetMigrationsStatusResultDto,
)


@final
class GetMigrationsStatusService:
    """Consulta qué migraciones están aplicadas y cuáles pendientes."""

    def __init__(self) -> None:
        self._migration_files_reader_file_repository = MigrationFilesReaderFileRepository.get_instance()
        self._migrations_reader_sqlite_repository = MigrationsReaderSqliteRepository.get_instance()
        self._migrations_writer_sqlite_repository = MigrationsWriterSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self,
        get_migrations_status_dto: GetMigrationsStatusDto,
    ) -> GetMigrationsStatusResultDto:
        self._fail_if_wrong_input(get_migrations_status_dto)

        db_path = get_migrations_status_dto.db_path or self._get_default_db_path()
        migration_files = self._migration_files_reader_file_repository.get_sorted_sql_files(
            get_migrations_status_dto.migrations_path
        )

        if not self._migrations_reader_sqlite_repository.database_exists(db_path):
            return GetMigrationsStatusResultDto.from_primitives({
                "applied": [],
                "pending": [migration_file.name for migration_file in migration_files],
            })

        await self._migrations_writer_sqlite_repository.ensure_migrations_table(db_path)
        applied_files = await self._migrations_reader_sqlite_repository.get_applied_file_names(db_path)

        return GetMigrationsStatusResultDto.from_primitives({
            "applied": sorted(applied_files),
            "pending": [
                migration_file.name
                for migration_file in migration_files
                if migration_file.name not in applied_files
            ],
        })

    def _fail_if_wrong_input(self, get_migrations_status_dto: GetMigrationsStatusDto) -> None:
        migrations_path = get_migrations_status_dto.migrations_path
        if not self._migration_files_reader_file_repository.path_exists(migrations_path):
            DevopsException.migrations_path_not_found(str(migrations_path))
        if not self._migration_files_reader_file_repository.is_directory(migrations_path):
            DevopsException.migrations_path_not_directory(str(migrations_path))

    def _get_default_db_path(self) -> Path:
        base_path = Path(__file__).parent.parent.parent.parent.parent
        return base_path / "data" / "learn_lang.db"
