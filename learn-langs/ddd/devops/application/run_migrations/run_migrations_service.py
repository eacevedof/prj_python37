from pathlib import Path
from typing import Self, final

from ddd.devops.domain.enums.migration_status_enum import MigrationStatusEnum
from ddd.devops.domain.enums.migration_file_enum import MigrationFileEnum
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
from ddd.devops.application.run_migrations.run_migrations_dto import RunMigrationsDto
from ddd.devops.application.run_migrations.run_migrations_result_dto import RunMigrationsResultDto


@final
class RunMigrationsService:
    """
    Ejecuta las migraciones SQL pendientes de forma controlada.

    - force=False: aplica solo las migraciones pendientes (diferencial).
    - force=True: elimina la BD, la recrea y ejecuta TODAS las migraciones.
    """

    def __init__(self) -> None:
        self._migration_files_reader_file_repository = MigrationFilesReaderFileRepository.get_instance()
        self._migrations_reader_sqlite_repository = MigrationsReaderSqliteRepository.get_instance()
        self._migrations_writer_sqlite_repository = MigrationsWriterSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, run_migrations_dto: RunMigrationsDto) -> RunMigrationsResultDto:
        self._fail_if_wrong_input(run_migrations_dto)

        db_path = run_migrations_dto.db_path or self._get_default_db_path()
        db_path.parent.mkdir(parents=True, exist_ok=True)

        if run_migrations_dto.force:
            self._migrations_writer_sqlite_repository.drop_database(db_path)

        await self._migrations_writer_sqlite_repository.ensure_migrations_table(db_path)

        if run_migrations_dto.force:
            await self._migrations_writer_sqlite_repository.clear_applied_migrations(db_path)

        applied_files = await self._migrations_reader_sqlite_repository.get_applied_file_names(db_path)
        migration_files = self._migration_files_reader_file_repository.get_sorted_sql_files(
            run_migrations_dto.migrations_path
        )

        results: list[dict[str, str]] = []
        applied_count = 0
        skipped_count = 0
        failed_count = 0

        for migration_file in migration_files:
            file_name = migration_file.name
            version = self._migration_files_reader_file_repository.extract_version(file_name)

            if not version:
                results.append(self._build_result(
                    file_name,
                    "",
                    MigrationStatusEnum.FAILED,
                    f"Could not extract version from filename (expected format: {MigrationFileEnum.FORMAT_HINT})",
                ))
                failed_count += 1
                continue

            if file_name in applied_files:
                results.append(self._build_result(file_name, version, MigrationStatusEnum.SKIPPED))
                skipped_count += 1
                continue

            result = await self._apply_migration(db_path, migration_file, version)
            results.append(result)

            if result["status"] == MigrationStatusEnum.APPLIED:
                applied_count += 1
            else:
                failed_count += 1

        return RunMigrationsResultDto.from_primitives({
            "total_migrations": len(migration_files),
            "applied_count": applied_count,
            "skipped_count": skipped_count,
            "failed_count": failed_count,
            "migrations": results,
        })

    async def _apply_migration(
        self,
        db_path: Path,
        migration_file: Path,
        version: str,
    ) -> dict[str, str]:
        """Aplica una migración individual. Captura el fallo para no abortar el lote."""
        try:
            sql_content = self._migration_files_reader_file_repository.get_sql_content(migration_file)
            await self._migrations_writer_sqlite_repository.apply_migration(
                db_path, sql_content, migration_file.name
            )
            return self._build_result(migration_file.name, version, MigrationStatusEnum.APPLIED)
        except Exception as e:
            return self._build_result(migration_file.name, version, MigrationStatusEnum.FAILED, str(e))

    def _build_result(
        self,
        file_name: str,
        version: str,
        status: MigrationStatusEnum,
        error: str = "",
    ) -> dict[str, str]:
        return {
            "filename": file_name,
            "version": version,
            "status": status.value,
            "error": error,
        }

    def _fail_if_wrong_input(self, run_migrations_dto: RunMigrationsDto) -> None:
        migrations_path = run_migrations_dto.migrations_path
        if not self._migration_files_reader_file_repository.path_exists(migrations_path):
            DevopsException.migrations_path_not_found(str(migrations_path))
        if not self._migration_files_reader_file_repository.is_directory(migrations_path):
            DevopsException.migrations_path_not_directory(str(migrations_path))

    def _get_default_db_path(self) -> Path:
        base_path = Path(__file__).parent.parent.parent.parent.parent
        return base_path / "data" / "learn_lang.db"
