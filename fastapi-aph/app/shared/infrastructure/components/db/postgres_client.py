import os
import asyncio
from typing import Optional, Dict, Any
import asyncpg
from asyncpg import Connection, Pool

class PostgresClient:
    __instance: Optional['PostgresClient'] = None
    __connection: Optional[Connection] = None
    __pool: Optional[Pool] = None
    
    def __new__(cls) -> 'PostgresClient':
        if cls.__instance is None:
            cls.__instance = super(PostgresClient, cls).__new__(cls)
        return cls.__instance
    
    @classmethod
    def get_instance(cls) -> 'PostgresClient':
        if cls.__instance is None:
            cls.__instance = cls()
        return cls.__instance
    
    async def get_client_by_env(self) -> Connection:
        """Get database connection using environment configuration"""
        if not self.__connection:
            config = self._get_conn_config_by_env()
            self.__connection = await asyncpg.connect(**config)
        return self.__connection
    
    async def get_pool(self) -> Pool:
        """Get connection pool for better performance"""
        if not self.__pool:
            config = self._get_conn_config_by_env()
            self.__pool = await asyncpg.create_pool(**config)
        return self.__pool
    
    async def close_connection(self) -> None:
        """Close single connection"""
        if self.__connection:
            await self.__connection.close()
            self.__connection = None
    
    async def close_pool(self) -> None:
        """Close connection pool"""
        if self.__pool:
            await self.__pool.close()
            self.__pool = None
    
    @classmethod
    async def close_all_connections(cls) -> None:
        """Close all connections and pools"""
        if cls.__instance:
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