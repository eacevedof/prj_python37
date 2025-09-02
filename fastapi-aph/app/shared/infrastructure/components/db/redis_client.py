import os
from typing import Optional
import redis.asyncio as redis

class RedisClient:
    __instance: Optional['RedisClient'] = None
    __client: Optional[redis.Redis] = None
    
    def __new__(cls):
        if cls.__instance is None:
            cls.__instance = super(RedisClient, cls).__new__(cls)
        return cls.__instance
    
    @classmethod
    def get_instance(cls) -> 'RedisClient':
        if cls.__instance is None:
            cls.__instance = cls()
        return cls.__instance
    
    def get_client_by_env(self) -> redis.Redis:
        """Get Redis client using environment configuration"""
        if not self.__client:
            redis_url = os.getenv("REDIS_URL", "redis://localhost:6379")
            redis_db = int(os.getenv("APP_REDIS_DB", "0"))
            
            # Parse URL or create from components
            if redis_url.startswith("redis://") or redis_url.startswith("rediss://"):
                self.__client = redis.from_url(redis_url, db=redis_db)
            else:
                # Fallback to individual components
                self.__client = redis.Redis(
                    host=os.getenv("APP_REDIS_HOST", "localhost"),
                    port=int(os.getenv("APP_REDIS_PORT", "6379")),
                    db=redis_db,
                    password=os.getenv("APP_REDIS_PASSWORD"),
                    decode_responses=True
                )
        
        return self.__client
    
    async def close_connection(self) -> None:
        """Close Redis connection"""
        if self.__client:
            await self.__client.close()
            self.__client = None
    
    @classmethod
    async def close_all_connections(cls) -> None:
        """Close all Redis connections"""
        if cls.__instance:
            await cls._instance.close_connection()