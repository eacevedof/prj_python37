import json
from abc import ABC
from typing import Optional, Dict, Any
import redis.asyncio as redis

from app.shared.infrastructure.enums.environment_enum import EnvironmentEnum
from app.shared.infrastructure.enums.env_key_enum import EnvKeyEnum, get_env
from app.shared.infrastructure.types.generic_row_type import GenericRowType
from app.shared.infrastructure.components.db.redis_client import RedisClient

class AbstractRedisRepository(ABC):
    SIXTY_SECONDS = 60
    
    def __init__(self):
        self.environment = get_env(EnvKeyEnum.APP_ENV) or EnvironmentEnum.DEVELOPMENT.value
        self._redis_client: Optional[redis.Redis] = None
        self._connection_open = False
    
    def __get_redis_client(self) -> redis.Redis:
        """Get Redis client instance"""
        if not self._redis_client:
            redis_client = RedisClient.get_instance()
            self._redis_client = redis_client.get_client_by_env()
        return self._redis_client
    
    async def _get_hash_set(self, redis_key: str) -> Optional[GenericRowType]:
        """Get hash set from Redis"""
        client = self.__get_redis_client()
        
        try:
            obj = await client.hgetall(redis_key)
            if not obj or len(obj) == 0:
                return None
            return dict(obj)
        except Exception as e:
            # Log error but don't raise to maintain compatibility
            return None
    
    async def _get_hash_set_for_bulk(self, redis_key: str) -> Optional[GenericRowType]:
        """Get hash set for bulk operations (assumes connection is already open)"""
        client = self.__get_redis_client()
        
        try:
            obj = await client.hgetall(redis_key)
            if not obj or len(obj) == 0:
                return None
            return dict(obj)
        except Exception as e:
            return None
    
    async def _save_single_hash_set(
        self, 
        redis_key: str, 
        obj_data: GenericRowType, 
        ttl_minutes: int
    ) -> None:
        """Save single hash set to Redis with TTL"""
        client = self.__get_redis_client()
        
        try:
            # Convert None values to empty strings for Redis compatibility
            redis_data = {k: str(v) if v is not None else "" for k, v in obj_data.items()}
            
            await client.hset(redis_key, mapping=redis_data)
            await client.expire(redis_key, ttl_minutes * self.SIXTY_SECONDS)
        except Exception as e:
            # Log error but don't raise to maintain compatibility
            pass
    
    async def _save_in_queue(
        self, 
        redis_queue_name: str, 
        obj_data: GenericRowType
    ) -> None:
        """Save data to Redis queue (list)"""
        client = self.__get_redis_client()
        
        try:
            json_data = json.dumps(obj_data, default=str)
            await client.lpush(redis_queue_name, json_data)
        except Exception as e:
            # Log error but don't raise to maintain compatibility
            pass
    
    async def _delete_single_key(self, redis_key: str) -> None:
        """Delete single key from Redis"""
        client = self.__get_redis_client()
        
        try:
            await client.delete(redis_key)
        except Exception as e:
            # Log error but don't raise to maintain compatibility
            pass
    
    async def _save_single_hash_set_for_bulk(
        self, 
        redis_key: str, 
        obj_data: GenericRowType, 
        ttl_minutes: int
    ) -> None:
        """Save single hash set for bulk operations"""
        client = self.__get_redis_client()
        
        try:
            # Convert None values to empty strings for Redis compatibility
            redis_data = {k: str(v) if v is not None else "" for k, v in obj_data.items()}
            
            await client.hset(redis_key, mapping=redis_data)
            await client.expire(redis_key, ttl_minutes * self.SIXTY_SECONDS)
        except Exception as e:
            # Log error but don't raise to maintain compatibility
            pass
    
    async def _open_connection(self) -> None:
        """Open Redis connection (for bulk operations)"""
        # With redis-py, connections are managed automatically
        # This method is kept for compatibility
        self._connection_open = True
    
    async def _close_connection(self) -> None:
        """Close Redis connection"""
        if self._redis_client:
            await self._redis_client.close()
            self._redis_client = None
        self._connection_open = False