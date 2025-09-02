from fastapi import Request
from typing import final
from app.shared.infrastructure.components.http.lz_response import LzResponse
from app.shared.infrastructure.components.logger import Logger
from app.shared.infrastructure.components.date_timer import DateTimer
from app.shared.infrastructure.enums.http_response_code_enum import HttpResponseCodeEnum
from app.shared.infrastructure.enums.http_response_message_enum import HttpResponseMessageEnum
from app.modules.healthcheck.application.get_health_check_status.get_health_check_status_service import GetHealthCheckStatusService

@final
class GetHealthCheckStatusController:
    """Health check controller following the original Deno implementation"""
    
    def __init__(self):
        pass
    
    @classmethod
    def get_instance(cls):
        return cls()
    
    async def invoke(self, request: Request) -> LzResponse:
        try:
            # Create health check DTO from HTTP request (matching Deno implementation)
            health_check_dto = self._create_health_check_dto_from_request(request)
            
            # Execute health check service
            health_check_result = await GetHealthCheckStatusService.get_instance().invoke(health_check_dto)
            
            return LzResponse.from_response_dto_primitives({
                "message": "get-health-check-status",
                "data": health_check_result
            })
            
        except Exception as error:
            Logger.get_instance().log_exception(error)
            return LzResponse.from_response_dto_primitives({
                "code": HttpResponseCodeEnum.INTERNAL_SERVER_ERROR,
                "message": HttpResponseMessageEnum.INTERNAL_SERVER_ERROR.value
            })
    
    def _create_health_check_dto_from_request(self, request: Request) -> dict:
        """Create health check DTO from FastAPI request (equivalent to GetHealthCheckStatusDto.fromHttpRequest)"""
        # Extract client IP from FastAPI request
        client_ip = getattr(request.client, 'host', '') if request.client else ''
        
        return {
            "remote_ip": client_ip,
            "request_time": DateTimer.get_instance().get_now_ymd_his(),
        }