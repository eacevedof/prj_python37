from typing import Dict, Any, Optional, final

from app.shared.infrastructure.components.date_timer import DateTimer
from app.shared.infrastructure.repositories.configuration.environment_reader_raw_repository import EnvironmentReaderRawRepository
from app.modules.users.infrastructure.repositories.users_reader_postgres_repository import UsersReaderPostgresRepository


@final
class GetHealthCheckStatusService:
    """Health check service following the original Deno implementation"""
    
    def __init__(self):
        self.environment_reader_raw_repository = EnvironmentReaderRawRepository.get_instance()
        self.users_reader_postgres_repository = UsersReaderPostgresRepository.get_instance()
    
    @classmethod
    def get_instance(cls):
        return cls()
    
    async def invoke(self, health_check_dto: Dict[str, Any]) -> Dict[str, Any]:
        """Execute health check following original Deno implementation"""
        date_timer = DateTimer.get_instance()
        
        # Test database connection by getting first user ID
        db_user_id = await self._get_db_health_check()
        
        return {
            "version": self.environment_reader_raw_repository.get_app_version(),
            "updated_at": self.environment_reader_raw_repository.get_app_version_update(),
            "server_tz": date_timer.get_timezone(),
            "request_ip": health_check_dto.get("remote_ip", ""),
            "request_time": health_check_dto.get("request_time", ""),
            "response_time": date_timer.get_now_ymd_his(),
            "db_ok": db_user_id,
        }
    
    async def _get_db_health_check(self) -> Optional[int]:
        """Test database connectivity by fetching first user ID"""
        try:
            return await self.users_reader_postgres_repository.get_first_user_id_for_health_check()
        except Exception:
            return None