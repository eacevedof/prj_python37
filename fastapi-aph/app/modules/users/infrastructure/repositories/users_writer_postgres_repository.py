from typing import Dict, Any, List

from app.shared.infrastructure.repositories.abstract_postgres_repository import AbstractPostgresRepository
from app.shared.infrastructure.types.generic_row_type import GenericRowType


class UsersWriterPostgresRepository(AbstractPostgresRepository):
    """Repository for writing user data to PostgreSQL"""
    
    @classmethod
    def get_instance(cls) -> 'UsersWriterPostgresRepository':
        return cls()
    
    async def create_user(self, new_user: Dict[str, Any]) -> str:
        """Create a new user and return the user UUID"""
        project_id = new_user["project_id"]
        project_user_uuid = new_user["project_user_uuid"]
        user_uuid = new_user["user_uuid"]
        
        sql = f"""
        -- create_user
        INSERT INTO app_users 
        (project_id, project_user_uuid, user_uuid)
        VALUES 
        (
        {project_id}, 
        '{self.get_escaped_sql_string(project_user_uuid)}', 
        '{self.get_escaped_sql_string(user_uuid)}'
        )
        
        RETURNING user_uuid;
        """
        self.log_sql(sql)
        result = await self.query(sql)
        
        if result:
            return str(result[0].get("user_uuid", ""))
        return ""
    
    async def soft_delete_user_by_user_id(self, user_id: int) -> str:
        """Soft delete user by user ID and return deleted timestamp"""
        sql = f"""
        -- soft_delete_user_by_user_id
        UPDATE app_users
            SET deleted_at = NOW()
        WHERE 1=1
        AND id = {user_id}
        
        RETURNING deleted_at;
        """
        result = await self.query(sql)
        
        if result:
            return str(result[0].get("deleted_at", ""))
        return ""