import re
import json
from abc import ABC
from typing import List, Optional, Dict, Any, Union
import asyncpg

from app.shared.infrastructure.enums.environment_enum import EnvironmentEnum
from app.shared.infrastructure.enums.env_key_enum import EnvKeyEnum, get_env, is_environment
from app.shared.infrastructure.enums.redis_minute_enum import RedisMinuteEnum
from app.shared.infrastructure.types.generic_row_type import GenericRowType
from app.shared.infrastructure.components.date_timer import DateTimer
from app.shared.infrastructure.components.logger import Logger
from app.shared.infrastructure.components.encoder import Encoder
from app.shared.infrastructure.components.db.redis_client import RedisClient
from app.shared.infrastructure.components.db.postgres_client import PostgresClient

class AbstractPostgresRepository(ABC):
    def __init__(self):
        self.environment = get_env(EnvKeyEnum.APP_ENV) or EnvironmentEnum.DEVELOPMENT.value
        self.last_id: Optional[int] = None
        self.affected_rows: int = 0
        
        self.encoder = Encoder.get_instance()
        self.date_timer = DateTimer.get_instance()
        self.logger = Logger.get_instance()
        
        self._postgres_client: Optional[asyncpg.Connection] = None
        self._redis_client = None
    
    async def _load_db_clients(self):
        """Initialize database clients if not already loaded"""
        if not self._postgres_client:
            postgres_client = PostgresClient.get_instance()
            self._postgres_client = await postgres_client.get_client_by_env()
        
        if not self._redis_client:
            redis_client = RedisClient.get_instance()
            self._redis_client = redis_client.get_client_by_env()
    
    async def query(self, sql: str) -> List[GenericRowType]:
        """Execute SELECT query against PostgreSQL"""
        await self._load_db_clients()
        return await self._get_from_postgres(sql)
    
    async def _get_from_postgres(self, sql: str) -> List[GenericRowType]:
        """Execute raw query against PostgreSQL"""
        if not self._postgres_client:
            await self._load_db_clients()
        
        try:
            rows = await self._postgres_client.fetch(sql)
            return [dict(row) for row in rows]
        except Exception as e:
            self.logger.log_error(f"PostgreSQL query failed: {sql}", e)
            raise
    
    async def query_redis(
        self, 
        sql: str, 
        ttl: int = RedisMinuteEnum.ONE_HOUR
    ) -> List[GenericRowType]:
        """Execute query with Redis caching"""
        await self._load_db_clients()
        
        redis_result = await self._get_from_redis(sql)
        if redis_result:
            return json.loads(redis_result)
        
        self._log_sql(sql, "query_redis")
        rows = await self._get_from_postgres(sql)
        if not rows:
            return []
        
        await self._save_in_redis(sql, rows, ttl)
        return rows
    
    async def _get_from_redis(self, sql: str) -> Optional[str]:
        """Get cached query result from Redis"""
        if not self._redis_client:
            return None
        
        main_table_name = self._get_table_name_from_sql(sql)
        redis_key = f"{self.environment}:sql:{main_table_name}:{self.encoder.get_md5_hash(sql)}"
        
        try:
            return await self._redis_client.get(redis_key)
        except Exception as e:
            self.logger.log_error("Redis get failed", e)
            return None
    
    def _get_table_name_from_sql(self, sql: str) -> str:
        """Extract table name from SQL query"""
        match = re.search(r'from\s+([a-zA-Z0-9_\.]+)', sql, re.IGNORECASE)
        return match.group(1) if match else ""
    
    async def _save_in_redis(
        self, 
        sql: str, 
        result: List[GenericRowType], 
        ttl_minutes: int
    ) -> None:
        """Save query result to Redis cache"""
        if not self._redis_client:
            return
        
        main_table_name = self._get_table_name_from_sql(sql)
        redis_key = f"{self.environment}:sql:{main_table_name}:{self.encoder.get_md5_hash(sql)}"
        
        try:
            json_data = json.dumps(result, default=str)
            await self._redis_client.set(redis_key, json_data, ex=ttl_minutes * 60)
        except Exception as e:
            self.logger.log_error("Redis save failed", e)
    
    async def command(self, sql: str) -> None:
        """Execute INSERT, UPDATE, or DELETE command"""
        # Remove comments before validating SQL
        cleaned_sql = re.sub(r'--.*$', '', sql, flags=re.MULTILINE)
        cleaned_sql = re.sub(r'/\*[\s\S]*?\*/', '', cleaned_sql).strip()
        
        if not re.match(r'^\s*(insert into |update |delete from )', cleaned_sql, re.IGNORECASE):
            raise ValueError("AbstractPostgresRepository.command: Only INSERT, UPDATE, or DELETE are allowed.")
        
        await self._load_db_clients()
        
        try:
            if re.match(r'^\s*insert into ', sql, re.IGNORECASE):
                if 'RETURNING' in sql.upper():
                    rows = await self._postgres_client.fetch(sql)
                    if rows and 'id' in rows[0]:
                        self.last_id = rows[0]['id']
                    self.affected_rows = len(rows)
                else:
                    result = await self._postgres_client.execute(sql)
                    self.affected_rows = int(result.split()[-1]) if result else 0
                    self.last_id = None
            else:
                # UPDATE or DELETE
                result = await self._postgres_client.execute(sql)
                self.affected_rows = int(result.split()[-1]) if result else 0
                self.last_id = None
                
        except Exception as e:
            self.logger.log_error(f"SQL command failed: {sql}", e)
            raise
    
    def get_escaped_sql_string(self, string: str) -> str:
        """Escape SQL string to prevent injection"""
        return string.replace("\\", "\\\\").replace("'", "\\'")
    
    def map_column_to_int(self, objects: List[Dict[str, Any]], column: str):
        """Convert column values to integers"""
        for obj in objects:
            if column in obj:
                value = obj[column]
                obj[column] = int(value) if value is not None else None
        return self
    
    def map_column_to_string(self, objects: List[Dict[str, Any]], column: str):
        """Convert column values to strings"""
        for obj in objects:
            if column in obj:
                obj[column] = str(obj[column]) if obj[column] is not None else ""
        return self
    
    def map_column_to_string_date(self, objects: List[Dict[str, Any]], column: str):
        """Convert datetime column values to string format"""
        for obj in objects:
            if column in obj:
                obj[column] = self.date_timer.get_date_ymd_his_as_string(obj[column])
        return self
    
    def get_integers_sql_in(self, entity_ids: List[int]) -> str:
        """Create SQL IN clause for integers"""
        if not entity_ids:
            return ''
        unique_ids = sorted(list(set(int(id) for id in entity_ids)))
        return ', '.join(map(str, unique_ids))
    
    def get_strings_sql_in(self, entity_uuids: List[str]) -> str:
        """Create SQL IN clause for strings"""
        if not entity_uuids:
            return ''
        unique_uuids = sorted(list(set(self.get_escaped_sql_string(str(uuid)) for uuid in entity_uuids)))
        return "'"+"', '".join(unique_uuids) + "'"
    
    def get_last_id(self) -> Optional[int]:
        """Get last inserted ID"""
        return self.last_id
    
    def get_affected_rows(self) -> int:
        """Get number of affected rows"""
        return self.affected_rows
    
    def _log_sql(self, sql: str, title: str = "") -> None:
        """Log SQL query"""
        if not is_environment(EnvironmentEnum.PRODUCTION):
            now = self.date_timer.get_now_ymd_his()
            print(f"[{now}] {sql}")  # CLI output
        
        self.logger.log_info(f"SQL Query {title}", {"sql": sql})