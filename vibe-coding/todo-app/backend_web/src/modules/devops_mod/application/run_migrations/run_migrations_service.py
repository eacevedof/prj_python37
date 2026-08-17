from typing import Self, final

from src.modules.shared.domain.enums.response_key_enum import ResponseKeyEnum

from src.modules.devops_mod.application.run_migrations.run_migrations_dto import RunMigrationsDto
from src.modules.devops_mod.application.run_migrations.run_migrations_result_dto import RunMigrationsResultDto
from src.modules.devops_mod.domain.enums.migration_file_enum import MigrationFileEnum
from src.modules.devops_mod.domain.enums.migration_result_enum import MigrationResultEnum
from src.modules.devops_mod.domain.enums.migration_status_enum import MigrationStatusEnum
from src.modules.devops_mod.domain.exceptions.devops_exception import DevopsException
from src.modules.devops_mod.infrastructure.repositories.migration_files_reader_file_repository import (
    MigrationFilesReaderFileRepository,
)
from src.modules.devops_mod.infrastructure.repositories.migrations_reader_sqlite_repository import (
    MigrationsReaderSqliteRepository,
)
from src.modules.devops_mod.infrastructure.runners.migration_runner import MigrationRunner


@final
class RunMigrationsService:
    """Caso de uso: aplicar las migraciones .sql pendientes.

    Es diferencial: compara los ficheros de la carpeta con lo ya registrado en la
    tabla `migrations` y aplica solo la diferencia. Por eso arrancar la app mil
    veces no ejecuta nada mil veces.

    No existe un modo "borrar y recrear". En SQLite la base es un fichero: para
    empezar de cero se borra con `make db-fresh`. Meter codigo destructivo dentro
    de la app, protegido por un flag que alguien puede activar en produccion, es
    un riesgo que no compensa ahorrarse un `rm`.
    """

    _run_migrations_dto: RunMigrationsDto
    _migration_files_reader_file_repository: MigrationFilesReaderFileRepository
    _migrations_reader_sqlite_repository: MigrationsReaderSqliteRepository
    _migration_runner: MigrationRunner

    def __init__(self) -> None:
        self._migration_files_reader_file_repository = MigrationFilesReaderFileRepository.get_instance()
        self._migrations_reader_sqlite_repository = MigrationsReaderSqliteRepository.get_instance()
        self._migration_runner = MigrationRunner.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __call__(self, run_migrations_dto: RunMigrationsDto) -> RunMigrationsResultDto:
        """Ejecuta el caso de uso.

        Returns:
            RunMigrationsResultDto: cuantas se aplicaron, saltaron y fallaron.

        Raises:
            DevopsException: si la carpeta de migraciones no existe o no es una carpeta.
        """
        self._run_migrations_dto = run_migrations_dto
        self._fail_if_wrong_input()

        applied_file_names = self.__get_applied_file_names()
        migration_files = self._migration_files_reader_file_repository.get_sorted_sql_files(
            self._run_migrations_dto.migrations_path
        )

        results: list[dict[str, str]] = []
        applied_count = 0
        skipped_count = 0
        failed_count = 0

        for migration_file in migration_files:
            file_name = migration_file.name
            version = self._migration_files_reader_file_repository.get_version(file_name)

            if not version:
                results.append(
                    self.__get_result(
                        file_name,
                        "",
                        MigrationStatusEnum.FAILED,
                        f"nombre invalido, se esperaba {MigrationFileEnum.FORMAT_HINT}",
                    )
                )
                failed_count += 1
                continue

            if file_name in applied_file_names:
                results.append(self.__get_result(file_name, version, MigrationStatusEnum.SKIPPED))
                skipped_count += 1
                continue

            status, error = self._migration_runner.run(migration_file)
            results.append(self.__get_result(file_name, version, status, error))

            if status == MigrationStatusEnum.APPLIED:
                applied_count += 1
            else:
                failed_count += 1

        return RunMigrationsResultDto.from_primitives({
            MigrationResultEnum.TOTAL_MIGRATIONS: len(migration_files),
            MigrationResultEnum.APPLIED_COUNT: applied_count,
            MigrationResultEnum.SKIPPED_COUNT: skipped_count,
            MigrationResultEnum.FAILED_COUNT: failed_count,
            MigrationResultEnum.MIGRATIONS: results,
        })

    def _fail_if_wrong_input(self) -> None:
        """Toda la validacion de entrada, junta y al principio del caso de uso.

        Este metodo esta en TODOS los services del proyecto. Siempre se llama lo
        primero dentro de `__call__` y siempre lanza la excepcion del modulo.
        """
        migrations_path = self._run_migrations_dto.migrations_path
        if not self._migration_files_reader_file_repository.has_path(migrations_path):
            DevopsException.not_found_custom(f"no existe la carpeta de migraciones: {migrations_path}")
        if not self._migration_files_reader_file_repository.is_directory(migrations_path):
            DevopsException.bad_request_custom(f"no es una carpeta: {migrations_path}")

    def __get_applied_file_names(self) -> set[str]:
        # En una base nueva la tabla de control todavia no existe: la crea la
        # PRIMERA migracion. Si no existe, no hay nada aplicado.
        if not self._migrations_reader_sqlite_repository.has_migrations_table():
            return set()
        return self._migrations_reader_sqlite_repository.get_applied_file_names()

    def __get_result(
        self,
        file_name: str,
        version: str,
        status: MigrationStatusEnum,
        error: str = "",
    ) -> dict[str, str]:
        return {
            MigrationResultEnum.FILE_NAME: file_name,
            MigrationResultEnum.VERSION: version,
            ResponseKeyEnum.STATUS: status.value,
            ResponseKeyEnum.ERROR: error,
        }
