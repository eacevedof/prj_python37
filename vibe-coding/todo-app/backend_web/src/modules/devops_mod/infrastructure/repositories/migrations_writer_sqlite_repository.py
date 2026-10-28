from typing import Self, final

from src.modules.devops_mod.domain.enums.migration_sql_enum import MigrationSqlEnum
from src.modules.shared.infrastructure.repositories.abstract_sqlite_repository import AbstractSqliteRepository


@final
class MigrationsWriterSqliteRepository(AbstractSqliteRepository):
    """Aplica un fichero de migracion y lo deja registrado."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def apply_migration(self, sql_content: str, file_name: str) -> None:
        """Ejecuta el .sql entero y anota que ya se aplico.

        Se usa `executescript()` y no `execute()` porque un fichero de migracion
        tiene VARIAS sentencias, y `execute()` solo admite una.

        Los BEGIN/COMMIT van dentro del texto porque `executescript()` no abre
        transaccion por su cuenta. Asi, si el fichero falla a la mitad, no queda
        media tabla creada.

        Queda una ventana minima entre "aplicada" y "registrada": si el proceso
        muere justo ahi, el siguiente arranque volveria a aplicarla. Por eso
        **toda migracion tiene que ser idempotente** (CREATE TABLE IF NOT EXISTS,
        CREATE INDEX IF NOT EXISTS, INSERT ... WHERE NOT EXISTS). No es un consejo:
        es lo que cierra ese agujero.
        """
        connection = self._get_connection()
        connection.executescript(f"{MigrationSqlEnum.BEGIN}\n{sql_content}\n{MigrationSqlEnum.COMMIT}")
        connection.execute(MigrationSqlEnum.INSERT_APPLIED, (file_name,))
        connection.commit()

    def rollback(self) -> None:
        """Deshace la transaccion abierta. Lo llama el runner cuando algo falla.

        Si el COMMIT del script no llego a ejecutarse, la transaccion sigue
        abierta: este rollback la cierra y deja la conexion utilizable para la
        siguiente migracion del lote.
        """
        self._get_connection().rollback()
