from typing import Optional, List

from app.shared.infrastructure.repositories.abstract_postgres_repository import AbstractPostgresRepository
from app.shared.infrastructure.types.generic_row_type import GenericRowType, StringRowType
from app.shared.infrastructure.enums.redis_minute_enum import RedisMinuteEnum


class ProjectsReaderPostgresRepository(AbstractPostgresRepository):
    """Repository for reading project data from PostgreSQL"""
    
    @classmethod
    def get_instance(cls) -> 'ProjectsReaderPostgresRepository':
        return cls()
    
    async def get_project_id_by_project_auth_token(self, project_api_key: str) -> Optional[int]:
        """Get project ID by authentication token"""
        config_api_key = "PROJECT_AUTH_TOKEN"  # ProjectConfigKeyEnum.PROJECT_AUTH_TOKEN
        sql = f"""
        -- get_project_id_by_api_key
        SELECT project_id
        FROM app_project_config
        WHERE 1=1
        AND config_key = '{config_api_key}'
        AND config_value = '{self.get_escaped_sql_string(project_api_key)}'
        LIMIT 1
        """
        result = await self.query_redis(sql, RedisMinuteEnum.EIGHT_HOURS)
        if not result:
            return None
        
        # Convert project_id to int
        project_id = result[0].get("project_id")
        return int(project_id) if project_id is not None else None
    
    async def get_project_config_by_project_id(self, project_id: int) -> List[StringRowType]:
        """Get project configuration by project ID"""
        config_api_key = "PROJECT_AUTH_TOKEN"
        sql = f"""
        -- get_project_config_by_project_id
        SELECT config_key, config_value
        FROM app_project_config
        WHERE 1=1
        AND project_id = '{project_id}'
        AND config_key != '{config_api_key}'
        ORDER BY config_key
        """
        result = await self.query_redis(sql, RedisMinuteEnum.EIGHT_HOURS)
        if not result:
            return []
        
        # Ensure string types
        for row in result:
            if "config_key" in row:
                row["config_key"] = str(row["config_key"])
            if "config_value" in row:
                row["config_value"] = str(row["config_value"])
        
        return result
    
    async def get_project_id_by_device_token(self, device_token: str) -> List[StringRowType]:
        """Get project configuration by device token"""
        config_api_key = "PROJECT_AUTH_TOKEN"
        sql = f"""
        -- get_project_config_by_project_id
        SELECT config_key, config_value
        FROM app_project_config
        WHERE 1=1
        AND project_id = '{self.get_escaped_sql_string(device_token)}'
        AND config_key != '{config_api_key}'
        ORDER BY config_key
        """
        result = await self.query_redis(sql, RedisMinuteEnum.EIGHT_HOURS)
        if not result:
            return []
        
        # Ensure string types
        for row in result:
            if "config_key" in row:
                row["config_key"] = str(row["config_key"])
            if "config_value" in row:
                row["config_value"] = str(row["config_value"])
        
        return result
    
    async def get_project_id_by_project_uuid(self, project_uuid: str) -> Optional[int]:
        """Get project ID by project UUID"""
        project_uuid = self.get_escaped_sql_string(project_uuid)
        sql = f"""
        -- get_project_id_by_project_uuid
        SELECT id
        FROM app_projects ap
        WHERE 1=1
        AND ap.project_uuid = '{project_uuid}'
        LIMIT 1
        """
        result = await self.query_redis(sql, RedisMinuteEnum.EIGHT_HOURS)
        if not result:
            return None
        
        project_id = result[0].get("id")
        return int(project_id) if project_id is not None else None