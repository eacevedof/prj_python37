import re
from pathlib import Path
from typing import final, Self

import aiosqlite

from ddd.devops.application.run_migrations.run_migrations_dto import RunMigrationsDto
from ddd.devops.application.run_migrations.run_migrations_result_dto import (
    RunMigrationsResultDto,
    MigrationResultDto,
)


@final
class RunMigrationsService:
    """
    Servicio para ejecutar migraciones SQL de forma controlada.

    Mantiene un registro de migraciones aplicadas en la tabla `schema_migrations`.
    Solo ejecuta migraciones que no hayan sido aplicadas previamente.
    """

    _SCHEMA_MIGRATIONS_TABLE = """
    CREATE TABLE IF NOT EXISTS migrations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        file_name TEXT NOT NULL UNIQUE,
        created_at TEXT DEFAULT (datetime('now'))
    )
    """

    _TIMESTAMP_PATTERN = re.compile(r"^(\d{14})-")

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self,
        run_migrations_dto: RunMigrationsDto
    ) -> RunMigrationsResultDto:
        """
        Ejecuta las migraciones.

        Args:
            run_migrations_dto: Datos con la ruta de migraciones y base de datos.
                - force=False: Solo aplica migraciones pendientes (diferencial)
                - force=True: Drop BD, crea BD, ejecuta TODAS las migraciones

        Returns:
            RunMigrationsResultDto con el resultado de las migraciones.
        """
        errors = run_migrations_dto.validate()
        if errors:
            return RunMigrationsResultDto.from_primitives({
                "total_migrations": 0,
                "applied_count": 0,
                "skipped_count": 0,
                "failed_count": 1,
                "migrations": [
                    MigrationResultDto(
                        filename="",
                        version="",
                        status="failed",
                        error="; ".join(errors),
                    )
                ],
            })

        db_path = run_migrations_dto.db_path or self._get_default_db_path()
        db_path.parent.mkdir(parents=True, exist_ok=True)

        # Force mode: eliminar BD existente
        if run_migrations_dto.force and db_path.exists():
            db_path.unlink()

        conn = await aiosqlite.connect(str(db_path))
        try:
            await conn.execute("PRAGMA foreign_keys = ON")
            await conn.execute(self._SCHEMA_MIGRATIONS_TABLE)
            await conn.commit()

            # Force mode: limpiar registro de migraciones (por si la BD no se eliminó)
            if run_migrations_dto.force:
                await conn.execute("DELETE FROM migrations")
                await conn.commit()

            applied_files = await self._get_applied_files(conn)
            migration_files = self._get_migration_files(run_migrations_dto.migrations_path)

            results: list[MigrationResultDto] = []
            applied_count = 0
            skipped_count = 0
            failed_count = 0

            for migration_file in migration_files:
                file_name = migration_file.name
                timestamp = self._extract_timestamp(file_name)

                if not timestamp:
                    results.append(MigrationResultDto(
                        filename=file_name,
                        version="",
                        status="failed",
                        error="Could not extract timestamp from filename (expected format: YYYYMMDDHHMMSS-description.sql)",
                    ))
                    failed_count += 1
                    continue

                if file_name in applied_files:
                    results.append(MigrationResultDto(
                        filename=file_name,
                        version=timestamp,
                        status="skipped",
                    ))
                    skipped_count += 1
                    continue

                result = await self._apply_migration(conn, migration_file, timestamp)
                results.append(result)

                if result.status == "applied":
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

        finally:
            await conn.close()

    def _get_default_db_path(self) -> Path:
        """Retorna la ruta por defecto de la base de datos."""
        base_path = Path(__file__).parent.parent.parent.parent.parent
        return base_path / "data" / "learn_lang.db"

    def _get_migration_files(self, migrations_path: Path) -> list[Path]:
        """Obtiene los archivos de migración ordenados por timestamp."""
        files = list(migrations_path.glob("*.sql"))
        return sorted(files, key=lambda f: self._extract_timestamp(f.name) or "")

    def _extract_timestamp(self, filename: str) -> str | None:
        """Extrae el timestamp del nombre del archivo (ej: '20260515205101-description.sql' -> '20260515205101')."""
        match = self._TIMESTAMP_PATTERN.match(filename)
        return match.group(1) if match else None

    async def _get_applied_files(self, conn: aiosqlite.Connection) -> set[str]:
        """Obtiene los nombres de archivos de migraciones ya aplicadas."""
        cursor = await conn.execute("SELECT file_name FROM migrations")
        rows = await cursor.fetchall()
        return {row[0] for row in rows}

    async def _apply_migration(
        self,
        conn: aiosqlite.Connection,
        migration_file: Path,
        timestamp: str,
    ) -> MigrationResultDto:
        """Aplica una migración individual."""
        try:
            sql_content = migration_file.read_text(encoding="utf-8")

            await conn.executescript(sql_content)

            await conn.execute(
                """
                INSERT INTO migrations (file_name, created_at)
                VALUES (?, datetime('now'))
                """,
                (migration_file.name,),
            )
            await conn.commit()

            return MigrationResultDto(
                filename=migration_file.name,
                version=timestamp,
                status="applied",
            )

        except Exception as e:
            await conn.rollback()
            return MigrationResultDto(
                filename=migration_file.name,
                version=timestamp,
                status="failed",
                error=str(e),
            )

    async def get_status(self, dto: RunMigrationsDto) -> dict[str, list[str]]:
        """
        Retorna el estado actual de las migraciones.

        Returns:
            Dict con 'applied' y 'pending' como listas de versiones.
        """
        errors = dto.validate()
        if errors:
            return {"applied": [], "pending": [], "errors": errors}

        db_path = dto.db_path or self._get_default_db_path()

        if not db_path.exists():
            migration_files = self._get_migration_files(dto.migrations_path)
            pending = [f.name for f in migration_files]
            return {"applied": [], "pending": pending}

        conn = await aiosqlite.connect(str(db_path))
        try:
            await conn.execute(self._SCHEMA_MIGRATIONS_TABLE)
            applied_files = await self._get_applied_files(conn)

            migration_files = self._get_migration_files(dto.migrations_path)
            pending = []

            for migration_file in migration_files:
                if migration_file.name not in applied_files:
                    pending.append(migration_file.name)

            return {
                "applied": sorted(applied_files),
                "pending": pending,
            }

        finally:
            await conn.close()
