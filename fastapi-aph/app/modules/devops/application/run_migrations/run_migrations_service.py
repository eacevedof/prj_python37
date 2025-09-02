from pathlib import Path
from typing import List, Optional, final

from app.shared.infrastructure.components.filer import Filer
from app.shared.infrastructure.components.cli.cli_color import CliColor
from app.modules.devops.infrastructure.repositories.run_migrations_reader_repository import RunMigrationsReaderRepository
from app.modules.devops.infrastructure.repositories.run_migrations_writer_repository import RunMigrationsWriterRepository
from app.shared.infrastructure.types.generic_row_type import GenericRowType


@final
class RunMigrationsService:
    """Service to handle database migrations"""
    
    MIGRATIONS_TABLE = "sys_migrations"
    
    def __init__(self):
        self.filer = Filer.get_instance()
        self.path_migrations = Path.cwd() / "database" / "migrations"
        self.run_migrations_reader_repository = RunMigrationsReaderRepository.get_instance()
        self.run_migrations_writer_repository = RunMigrationsWriterRepository.get_instance()
        
        self.sql_migrations_files: List[str] = []
        self.sql_files_to_be_ran: List[str] = []
    
    @classmethod
    def get_instance(cls) -> 'RunMigrationsService':
        return cls()
    
    async def invoke(self) -> None:
        """Execute the migration process"""
        # Uncomment to force database from scratch
        # await self.run_migrations_writer_repository.drop_migrations_table()
        
        await self._create_migrations_table_if_does_not_exist()
        
        await self._load_migrations_files()
        if not self.sql_migrations_files:
            self._print("No migrations files found")
            return
        
        await self._load_files_to_be_ran()
        if not self.sql_files_to_be_ran:
            self._print("No migrations files to be ran")
            return
        
        await self._run_migrations()
    
    async def _create_migrations_table_if_does_not_exist(self) -> None:
        """Create migrations table if it doesn't exist"""
        exists = await self.run_migrations_reader_repository.does_table_exist(
            self.MIGRATIONS_TABLE
        )
        if exists:
            self._print("migrations table won't be created, already exists")
            return
        
        self._print("creating migrations table")
        await self.run_migrations_writer_repository.create_migrations_table()
    
    async def _load_migrations_files(self) -> None:
        """Load available migration files from directory"""
        try:
            sql_files = await self.filer.get_files_in_directory(str(self.path_migrations))
        except Exception as e:
            CliColor.die_red(f"Error reading migrations directory: {self.path_migrations}")
        
        # Filter SQL files excluding system migrations (starting with 0000-)
        sql_files = [
            file for file in sql_files 
            if file.endswith(".sql") and not file.startswith("0000-")
        ]
        
        if not sql_files:
            return
        
        sql_files.sort()
        self.sql_migrations_files = sql_files
    
    async def _load_files_to_be_ran(self) -> None:
        """Determine which migration files need to be executed"""
        ran_files = await self.run_migrations_reader_repository.get_ran_migrations_files()
        if not ran_files:
            self.sql_files_to_be_ran = self.sql_migrations_files
            return
        
        # Extract migration file names from database records
        ran_file_names = [
            str(record["migration_file"])
            for record in ran_files
            if record["migration_file"] is not None
        ]
        
        # Filter out already run migrations
        self.sql_files_to_be_ran = [
            sql_file for sql_file in self.sql_migrations_files
            if sql_file not in ran_file_names
        ]
    
    async def _run_migrations(self) -> None:
        """Execute the pending migrations"""
        max_batch = await self.run_migrations_reader_repository.get_max_batch()
        batch = max_batch + 1
        
        self._print(f"running migrations batch: {batch}")
        
        for sql_file in self.sql_files_to_be_ran:
            self._print(f"running migration: {sql_file}")
            await self.run_migrations_writer_repository.run_sql_from_sql_file(sql_file)
            
            self._print(f"save migration: {sql_file}")
            await self.run_migrations_writer_repository.save_migration(sql_file, batch)
    
    def _print(self, message: str) -> None:
        """Print message in green color"""
        CliColor.echo_green(message)