from typing import final


@final
class MigrationResultEnum:
    """Claves del resultado que devuelve el caso de uso RunMigrations.

    Ese resultado no lo consume ningun cliente HTTP: lo lee el arranque para
    escribir en consola cuantas migraciones se aplicaron. Aun asi las claves van
    aqui, porque la regla es la misma para todo el proyecto: ninguna cadena que
    forme parte de una estructura de datos se escribe suelta.
    """

    TOTAL_MIGRATIONS = "total_migrations"
    APPLIED_COUNT = "applied_count"
    SKIPPED_COUNT = "skipped_count"
    FAILED_COUNT = "failed_count"
    MIGRATIONS = "migrations"
    FILE_NAME = "file_name"
    VERSION = "version"
    MIGRATIONS_PATH = "migrations_path"
