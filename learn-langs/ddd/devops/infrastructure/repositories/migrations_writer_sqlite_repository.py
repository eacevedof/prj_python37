from pathlib import Path
from typing import Self, final

import aiosqlite

from ddd.devops.domain.enums.migrations_schema_enum import MigrationsSchemaEnum


@final
class MigrationsWriterSqliteRepository:
    """Escritura del registro de migraciones (datasource: sqlite)."""

    _PRAGMA_FOREIGN_KEYS = "PRAGMA foreign_keys = ON"

    _CREATE_TABLE_SQL = (
        f"CREATE TABLE IF NOT EXISTS {MigrationsSchemaEnum.TABLE} ("
        f"  {MigrationsSchemaEnum.COL_ID} INTEGER PRIMARY KEY AUTOINCREMENT,"
        f"  {MigrationsSchemaEnum.COL_FILE_NAME} TEXT NOT NULL UNIQUE,"
        f"  {MigrationsSchemaEnum.COL_CREATED_AT} TEXT DEFAULT (datetime('now'))"
        f")"
    )

    _INSERT_MIGRATION_SQL = (
        f"INSERT INTO {MigrationsSchemaEnum.TABLE} "
        f"({MigrationsSchemaEnum.COL_FILE_NAME}, {MigrationsSchemaEnum.COL_CREATED_AT}) "
        f"VALUES (?, datetime('now'))"
    )

    _DELETE_ALL_SQL = f"DELETE FROM {MigrationsSchemaEnum.TABLE}"

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def drop_database(self, db_path: Path) -> None:
        if db_path.exists():
            db_path.unlink()

    async def ensure_migrations_table(self, db_path: Path) -> None:
        async with aiosqlite.connect(str(db_path)) as conn:
            await conn.execute(self._PRAGMA_FOREIGN_KEYS)
            await conn.executescript(self._CREATE_TABLE_SQL)
            await conn.commit()

    async def clear_applied_migrations(self, db_path: Path) -> None:
        async with aiosqlite.connect(str(db_path)) as conn:
            await conn.execute(self._DELETE_ALL_SQL)
            await conn.commit()

    async def apply_migration(self, db_path: Path, sql_content: str, file_name: str) -> None:
        async with aiosqlite.connect(str(db_path)) as conn:
            await conn.execute(self._PRAGMA_FOREIGN_KEYS)
            await conn.executescript(sql_content)
            await conn.execute(self._INSERT_MIGRATION_SQL, (file_name,))
            await conn.commit()
