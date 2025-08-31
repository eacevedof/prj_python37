import os
import asyncio
from typing import Optional, Dict, Any
import asyncpg
from asyncpg import Connection, Pool

class PostgresClient:
    _instance: Optional['PostgresClient'] = None
    _connection: Optional[Connection] = None
    _pool: Optional[Pool] = None
    
    def __new__(cls):
        if cls._instance is None:
            cls._instance = super(PostgresClient, cls).__new__(cls)
        return cls._instance
    
    @classmethod
    def get_instance(cls) -> 'PostgresClient':
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance
    
    async def get_client_by_env(self) -> Connection:
        """Get database connection using environment configuration"""
        if not self._connection:
            config = self._get_conn_config_by_env()
            self._connection = await asyncpg.connect(**config)
        return self._connection
    
    async def get_pool(self) -> Pool:
        """Get connection pool for better performance"""
        if not self._pool:
            config = self._get_conn_config_by_env()
            self._pool = await asyncpg.create_pool(**config)
        return self._pool
    
    async def close_connection(self) -> None:
        """Close single connection"""
        if self._connection:
            await self._connection.close()
            self._connection = None
    
    async def close_pool(self) -> None:
        """Close connection pool"""
        if self._pool:
            await self._pool.close()
            self._pool = None
    
    @classmethod
    async def close_all_connections(cls) -> None:
        """Close all connections and pools"""
        if cls._instance:
            await cls._instance.close_connection()
            await cls._instance.close_pool()
    
    def _get_conn_config_by_env(self) -> Dict[str, Any]:
        """Get connection configuration from environment variables"""
        
        # Try DATABASE_URL first (Heroku/Railway style)
        database_url = os.getenv("DATABASE_URL")
        if database_url:
            return {"dsn": database_url}
        
        # Fallback to individual environment variables
        host = os.getenv("APP_DB_HOST", "localhost")
        port = int(os.getenv("APP_DB_PORT", "5432"))
        database = os.getenv("APP_DB_NAME", "postgres")
        user = os.getenv("APP_DB_USER", "postgres")
        password = os.getenv("APP_DB_PWD", "postgres")
        
        config = {
            "host": host,
            "port": port,
            "database": database,
            "user": user,
            "password": password
        }
        
        # Add SSL configuration for production
        if os.getenv("APP_ENV") == "production":
            config["ssl"] = "require"
        
        return config