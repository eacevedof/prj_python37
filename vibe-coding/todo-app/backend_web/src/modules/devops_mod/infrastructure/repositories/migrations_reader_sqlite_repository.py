from typing import Self, final

from src.modules.devops_mod.domain.enums.migration_sql_enum import MigrationSqlEnum
from src.modules.shared.infrastructure.repositories.abstract_sqlite_repository import AbstractSqliteRepository


@final
class MigrationsReaderSqliteRepository(AbstractSqliteRepository):
    """Consulta que migraciones estan ya aplicadas.

    Nombre = MigrationsReaderSqliteRepository:
      Migrations -> de que tabla lee
      Reader     -> solo lee (los que escriben son Writer)
      Sqlite     -> de donde (el datasource, obligatorio en el nombre)
    """

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def has_migrations_table(self) -> bool:
        """¿Existe ya la tabla de control?

        En Postgres esto seria `to_regclass(...)`; en SQLite se pregunta al
        catalogo interno `sqlite_master`, que es una tabla normal que lista todo
        lo que hay en la base.

        Hace falta preguntarlo porque la propia tabla `migrations` se crea con la
        primera migracion: en una base nueva todavia no existe cuando el migrador
        arranca.
        """
        cursor = self._get_connection().cursor()
        cursor.execute(MigrationSqlEnum.TABLE_EXISTS, (MigrationSqlEnum.MIGRATIONS_TABLE,))
        return cursor.fetchone() is not None

    def get_applied_file_names(self) -> set[str]:
        cursor = self._get_connection().cursor()
        cursor.execute(MigrationSqlEnum.SELECT_APPLIED)
        return {str(row["file_name"]) for row in cursor.fetchall()}
