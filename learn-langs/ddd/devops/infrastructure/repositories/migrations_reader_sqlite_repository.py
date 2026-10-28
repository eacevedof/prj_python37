from pathlib import Path
from typing import Self, final

import aiosqlite

from ddd.devops.domain.enums.migrations_schema_enum import MigrationsSchemaEnum


@final
class MigrationsReaderSqliteRepository:
    """Lectura del registro de migraciones aplicadas (datasource: sqlite)."""

    _SELECT_APPLIED_SQL = (
        f"SELECT {MigrationsSchemaEnum.COL_FILE_NAME} FROM {MigrationsSchemaEnum.TABLE}"
    )

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def database_exists(self, db_path: Path) -> bool:
        return db_path.exists()

    async def get_applied_file_names(self, db_path: Path) -> set[str]:
        async with aiosqlite.connect(str(db_path)) as conn:
            cursor = await conn.execute(self._SELECT_APPLIED_SQL)
            rows = await cursor.fetchall()
            return {row[0] for row in rows}
