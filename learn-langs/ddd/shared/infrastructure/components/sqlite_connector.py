import aiosqlite
from pathlib import Path
from typing import final, Self


@final
class SqliteConnector:
    """Gestiona la conexión a SQLite."""

    _instance: "SqliteConnector | None" = None
    _db_path: str = ""
    _initialized: bool = False

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls, db_path: str = "") -> Self:
        if cls._instance is None:
            cls._instance = cls()
        if db_path:
            cls._instance._db_path = db_path
        return cls._instance

    @classmethod
    def set_db_path(cls, db_path: str) -> None:
        """Configura la ruta de la base de datos."""
        instance = cls.get_instance()
        instance._db_path = db_path

    @property
    def db_path(self) -> str:
        if not self._db_path:
            base_path = Path(__file__).parent.parent.parent.parent.parent
            self._db_path = str(base_path / "data" / "learn_lang.db")
        return self._db_path

    @property
    def migrations_path(self) -> Path:
        """Ruta de las migraciones."""
        return (
            Path(__file__).parent.parent.parent.parent /
            "vocabulary" / "infrastructure" / "persistence" / "migrations"
        )

    async def _create_connection(self) -> aiosqlite.Connection:
        """Crea una nueva conexión a la base de datos."""
        db_file = Path(self.db_path)
        db_file.parent.mkdir(parents=True, exist_ok=True)

        conn = await aiosqlite.connect(self.db_path)
        conn.row_factory = aiosqlite.Row
        await conn.execute("PRAGMA foreign_keys = ON")
        return conn

    async def initialize_database(self, force: bool = False) -> None:
        """
        Inicializa la base de datos ejecutando las migraciones.

        Args:
            force: Si True, elimina la BD y ejecuta todas las migraciones.
                   Si False, solo ejecuta migraciones pendientes (diferencial).
        """
        if self._initialized and not force:
            return

        from ddd.devops.application.run_migrations import (
            RunMigrationsDto,
            RunMigrationsService,
        )

        service = RunMigrationsService.get_instance()
        result = await service(RunMigrationsDto.from_primitives({
            "migrations_path": self.migrations_path,
            "db_path": self.db_path,
            "force": force,
        }))

        if result.failed_count > 0:
            failed = [m for m in result.migrations if m.status == "failed"]
            errors = "; ".join(m.error or m.filename for m in failed)
            raise RuntimeError(f"Migration failed: {errors}")

        self._initialized = True

    async def fetch_one(self, query: str, params: tuple = ()) -> dict | None:
        """Ejecuta una query y retorna una fila como dict."""
        conn = await self._create_connection()
        try:
            cursor = await conn.execute(query, params)
            row = await cursor.fetchone()
            return dict(row) if row else None
        finally:
            await conn.close()

    async def fetch_all(self, query: str, params: tuple = ()) -> list[dict]:
        """Ejecuta una query y retorna todas las filas como lista de dicts."""
        conn = await self._create_connection()
        try:
            cursor = await conn.execute(query, params)
            rows = await cursor.fetchall()
            return [dict(row) for row in rows]
        finally:
            await conn.close()

    async def insert(self, query: str, params: tuple = ()) -> int:
        """Ejecuta un INSERT y retorna el lastrowid."""
        conn = await self._create_connection()
        try:
            cursor = await conn.execute(query, params)
            await conn.commit()
            return cursor.lastrowid or 0
        finally:
            await conn.close()

    async def update(self, query: str, params: tuple = ()) -> int:
        """Ejecuta un UPDATE y retorna el número de filas afectadas."""
        conn = await self._create_connection()
        try:
            cursor = await conn.execute(query, params)
            await conn.commit()
            return cursor.rowcount
        finally:
            await conn.close()

    async def delete(self, query: str, params: tuple = ()) -> int:
        """Ejecuta un DELETE y retorna el número de filas afectadas."""
        return await self.update(query, params)
