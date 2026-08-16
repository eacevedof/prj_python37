from enum import StrEnum
from typing import final


@final
class MigrationsSchemaEnum(StrEnum):
    """Nombres de tabla y columnas del registro de migraciones."""

    TABLE = "migrations"
    COL_ID = "id"
    COL_FILE_NAME = "file_name"
    COL_CREATED_AT = "created_at"
