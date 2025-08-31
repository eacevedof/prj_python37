from typing import Optional, List

from app.shared.infrastructure.repositories.abstract_postgres_repository import AbstractPostgresRepository
from app.shared.infrastructure.types.generic_row_type import GenericRowType
from app.shared.infrastructure.enums.redis_minute_enum import RedisMinuteEnum


class UsersReaderPostgresRepository(AbstractPostgresRepository):
    """Repository for reading user data from PostgreSQL"""
    
    @classmethod
    def get_instance(cls) -> 'UsersReaderPostgresRepository':
        return cls()
    
    async def get_first_user_id_for_health_check(self) -> Optional[int]:
        """Get first user ID for health check purposes"""
        sql = """
        -- get_first_user_id_for_health_check
        SELECT id
        FROM app_users
        WHERE 1=1
        LIMIT 1;
        """
        self.log_sql(sql)
        result = await self.query(sql)
        if result:
            return int(result[0]["id"])
        return None
    
    async def get_user_id_by_user_uuid(self, user_uuid: str) -> Optional[int]:
        """Get user ID by user UUID"""
        sql = f"""
        -- get_user_id_by_user_uuid
        SELECT id
        FROM app_users
        WHERE 1=1
        AND user_uuid = '{self.get_escaped_sql_string(user_uuid)}';
        """
        result = await self.query_redis(sql, RedisMinuteEnum.EIGHT_HOURS)
        if result:
            return int(result[0]["id"])
        return None
    
    async def get_user_uuid_by_project_id_and_project_user_uuid(
        self, 
        project_id: int, 
        project_user_uuid: str
    ) -> str:
        """Get user UUID by project ID and project user UUID"""
        sql = f"""
        -- get_user_uuid_by_project_id_and_project_user_uuid
        SELECT au.user_uuid
        FROM app_users au
        WHERE 1=1
        AND au.project_id = {project_id}
        AND au.project_user_uuid = '{self.get_escaped_sql_string(project_user_uuid)}';
        """
        self.log_sql(sql)
        result = await self.query(sql)
        if result:
            return str(result[0]["user_uuid"])
        return ""
    
    async def get_user_id_with_soft_delete_by_user_uuid(self, user_uuid: str) -> Optional[GenericRowType]:
        """Get user ID with soft delete status by user UUID"""
        sql = f"""
        -- get_user_id_with_soft_delete_by_user_uuid
        SELECT id, deleted_at
        FROM app_users
        WHERE 1=1
        AND user_uuid = '{self.get_escaped_sql_string(user_uuid)}';
        """
        self.log_sql(sql)
        result = await self.query(sql)
        if result:
            return result[0]
        return None