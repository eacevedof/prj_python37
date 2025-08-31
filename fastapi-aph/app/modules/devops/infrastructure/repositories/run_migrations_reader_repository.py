from typing import List, Dict, Any

from app.shared.infrastructure.repositories.abstract_postgres_repository import AbstractPostgresRepository
from app.shared.infrastructure.types.generic_row_type import GenericRowType


class RunMigrationsReaderRepository(AbstractPostgresRepository):
    """Repository for reading migration-related data"""
    
    @classmethod
    def get_instance(cls) -> 'RunMigrationsReaderRepository':
        return cls()
    
    async def does_table_exist(self, table_name: str) -> bool:
        """Check if a table exists in the database"""
        sql = f"""
        -- does_table_exist
        SELECT COUNT(*) AS n_rows
        FROM information_schema.tables
        WHERE table_schema = 'public'
        AND table_name = '{self.get_escaped_sql_string(table_name)}'
        """
        self.log_sql(sql)
        result = await self.query(sql)
        if not result:
            return False
        
        return bool(int(result[0]["n_rows"]))
    
    async def get_current_database(self) -> str:
        """Get the current database name"""
        sql = """
        -- get_current_database
        SELECT current_database() AS database_name
        """
        self.log_sql(sql)
        result = await self.query(sql)
        if not result:
            return ""
        
        return str(result[0]["database_name"])
    
    async def get_ran_migrations_files(self) -> List[GenericRowType]:
        """Get list of migration files that have been run"""
        sql = """
        -- get_ran_migrations_files
        SELECT id, migration_file
        FROM sys_migrations
        ORDER BY migration_file
        """
        self.log_sql(sql)
        result = await self.query(sql)
        if not result:
            return []
        
        # Convert id column to int
        for row in result:
            if "id" in row and row["id"] is not None:
                row["id"] = int(row["id"])
        
        return result
    
    async def get_max_batch(self) -> int:
        """Get the maximum batch number from migrations"""
        sql = """
        -- get_max_batch
        SELECT MAX(batch) AS max_batch
        FROM sys_migrations
        """
        self.log_sql(sql)
        result = await self.query(sql)
        if not result:
            return 0
        
        max_batch = result[0]["max_batch"]
        return int(max_batch) if max_batch is not None else 0