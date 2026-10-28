from enum import StrEnum
from typing import final


@final
class MigrationFileEnum(StrEnum):
    """Convención de nombres de los archivos de migración .sql."""

    SQL_GLOB = "*.sql"
    TIMESTAMP_REGEX = r"^(\d{14})-"
    FORMAT_HINT = "YYYYMMDDHHMMSS-description.sql"
