from pathlib import Path
from typing import Self, final

from src.modules.devops_mod.domain.enums.migration_status_enum import MigrationStatusEnum
from src.modules.devops_mod.infrastructure.repositories.migration_files_reader_file_repository import (
    MigrationFilesReaderFileRepository,
)
from src.modules.devops_mod.infrastructure.repositories.migrations_writer_sqlite_repository import (
    MigrationsWriterSqliteRepository,
)


@final
class MigrationRunner:
    """Aplica UNA migracion de forma aislada.

    ATENCION: este es el UNICO sitio de toda la app, fuera de un controller, donde
    se captura una excepcion. La excepcion a la regla esta documentada aqui para
    que se pueda auditar:

    Las migraciones corren en el arranque, donde no hay ningun controller delante
    que capture. Y una migracion que falla no debe (a) tumbar la app en silencio
    ni (b) abortar el resto del lote. Asi que se captura, se deshace la
    transaccion para que la conexion siga siendo usable, y se devuelve el fallo
    como DATO -un estado y un mensaje- en vez de como excepcion.

    Gracias a eso, `RunMigrationsService` no tiene try/except: solo orquesta.
    """

    _migration_files_reader_file_repository: MigrationFilesReaderFileRepository
    _migrations_writer_sqlite_repository: MigrationsWriterSqliteRepository

    def __init__(self) -> None:
        self._migration_files_reader_file_repository = MigrationFilesReaderFileRepository.get_instance()
        self._migrations_writer_sqlite_repository = MigrationsWriterSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def run(self, migration_file: Path) -> tuple[MigrationStatusEnum, str]:
        try:
            sql_content = self._migration_files_reader_file_repository.get_sql_content(migration_file)
            self._migrations_writer_sqlite_repository.apply_migration(sql_content, migration_file.name)
            return MigrationStatusEnum.APPLIED, ""
        except Exception as exception:  # runner de lote: excepcion permitida y razonada arriba
            self._migrations_writer_sqlite_repository.rollback()
            return MigrationStatusEnum.FAILED, str(exception)
