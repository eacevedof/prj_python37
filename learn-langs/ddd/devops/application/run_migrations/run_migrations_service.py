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
        CREATE TABLE IF NOT EXISTS schema_migrations (
            version TEXT PRIMARY KEY,
            filename TEXT NOT NULL,
            applied_at TEXT DEFAULT (datetime('now')),
            checksum TEXT
        )
    """

    _VERSION_PATTERN = re.compile(r"^(\d+)[_-]")

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: RunMigrationsDto) -> RunMigrationsResultDto:
        """
        Ejecuta las migraciones pendientes.

        Args:
            dto: Datos con la ruta de migraciones y base de datos.

        Returns:
            RunMigrationsResultDto con el resultado de las migraciones.
        """
        errors = dto.validate()
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

        db_path = dto.db_path or self._get_default_db_path()
        db_path.parent.mkdir(parents=True, exist_ok=True)

        conn = await aiosqlite.connect(str(db_path))
        try:
            await conn.execute("PRAGMA foreign_keys = ON")
            await conn.execute(self._SCHEMA_MIGRATIONS_TABLE)
            await conn.commit()

            applied_versions = await self._get_applied_versions(conn)
            migration_files = self._get_migration_files(dto.migrations_path)

            results: list[MigrationResultDto] = []
            applied_count = 0
            skipped_count = 0
            failed_count = 0

            for migration_file in migration_files:
                version = self._extract_version(migration_file.name)
                if not version:
                    results.append(MigrationResultDto(
                        filename=migration_file.name,
                        version="",
                        status="failed",
                        error="Could not extract version from filename",
                    ))
                    failed_count += 1
                    continue

                if version in applied_versions:
                    results.append(MigrationResultDto(
                        filename=migration_file.name,
                        version=version,
                        status="skipped",
                    ))
                    skipped_count += 1
                    continue

                result = await self._apply_migration(conn, migration_file, version)
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
        """Obtiene los archivos de migración ordenados por versión."""
        files = list(migrations_path.glob("*.sql"))
        return sorted(files, key=lambda f: self._extract_version(f.name) or "")

    def _extract_version(self, filename: str) -> str | None:
        """Extrae la versión del nombre del archivo (ej: '001_initial.sql' -> '001')."""
        match = self._VERSION_PATTERN.match(filename)
        return match.group(1) if match else None

    def _compute_checksum(self, content: str) -> str:
        """Calcula un checksum simple del contenido."""
        import hashlib
        return hashlib.md5(content.encode()).hexdigest()

    async def _get_applied_versions(self, conn: aiosqlite.Connection) -> set[str]:
        """Obtiene las versiones de migraciones ya aplicadas."""
        cursor = await conn.execute("SELECT version FROM schema_migrations")
        rows = await cursor.fetchall()
        return {row[0] for row in rows}

    async def _apply_migration(
        self,
        conn: aiosqlite.Connection,
        migration_file: Path,
        version: str,
    ) -> MigrationResultDto:
        """Aplica una migración individual."""
        try:
            sql_content = migration_file.read_text(encoding="utf-8")
            checksum = self._compute_checksum(sql_content)

            await conn.executescript(sql_content)

            await conn.execute(
                """
                INSERT INTO schema_migrations (version, filename, checksum)
                VALUES (?, ?, ?)
                """,
                (version, migration_file.name, checksum),
            )
            await conn.commit()

            return MigrationResultDto(
                filename=migration_file.name,
                version=version,
                status="applied",
            )

        except Exception as e:
            await conn.rollback()
            return MigrationResultDto(
                filename=migration_file.name,
                version=version,
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
            pending = [
                self._extract_version(f.name) or f.name
                for f in migration_files
            ]
            return {"applied": [], "pending": pending}

        conn = await aiosqlite.connect(str(db_path))
        try:
            await conn.execute(self._SCHEMA_MIGRATIONS_TABLE)
            applied_versions = await self._get_applied_versions(conn)

            migration_files = self._get_migration_files(dto.migrations_path)
            pending = []

            for migration_file in migration_files:
                version = self._extract_version(migration_file.name)
                if version and version not in applied_versions:
                    pending.append(version)

            return {
                "applied": sorted(applied_versions),
                "pending": pending,
            }

        finally:
            await conn.close()
