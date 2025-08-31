import os
from pathlib import Path

from app.shared.infrastructure.repositories.abstract_postgres_repository import AbstractPostgresRepository


class RunMigrationsWriterRepository(AbstractPostgresRepository):
    """Repository for writing migration-related data"""
    
    def __init__(self):
        super().__init__()
        # Get path to migrations directory
        self.path_migrations = Path.cwd() / "database" / "migrations"
    
    @classmethod
    def get_instance(cls) -> 'RunMigrationsWriterRepository':
        return cls()
    
    async def drop_migrations_table(self) -> None:
        """Drop the sys_migrations table if it exists"""
        sql = "DROP TABLE IF EXISTS public.sys_migrations"
        await self.query(sql)
    
    async def create_migrations_table(self) -> None:
        """Create the sys_migrations table"""
        sql = await self._get_file_content_sql("0000-create-sys-migrations-table.sql")
        if sql:
            await self.query(sql)
    
    async def _get_file_content_sql(self, filename: str) -> str:
        """Read SQL content from migration file"""
        try:
            file_path = self.path_migrations / filename
            if file_path.exists():
                return file_path.read_text().strip()
            return ""
        except Exception:
            return ""
    
    async def run_sql_from_sql_file(self, filename: str) -> None:
        """Execute SQL from a migration file"""
        sql = await self._get_file_content_sql(filename)
        if sql:
            self.log_sql(sql)
            await self.query(sql)
    
    async def save_migration(self, filename: str, batch: int) -> None:
        """Save a migration record to the database"""
        sql = f"""
        -- save_migration_file
        INSERT INTO sys_migrations (migration_file, batch, created_at)
        VALUES ('{self.get_escaped_sql_string(filename)}', {batch}, NOW())
        """
        self.log_sql(sql)
        await self.query(sql)