from fastapi import Request
from typing import final
from app.shared.infrastructure.components.http.lz_response import LzResponse
from app.shared.infrastructure.components.logger import Logger
from app.shared.infrastructure.enums.http_response_code_enum import HttpResponseCodeEnum
from app.shared.infrastructure.enums.http_response_message_enum import HttpResponseMessageEnum
from app.modules.devops.application.services.check_app_service import CheckAppService

@final
class CheckAppController:
    def __init__(self):
        self.logger = Logger.get_instance()
    
    @classmethod
    def get_instance(cls):
        return cls()
    
    async def invoke(self, request: Request) -> LzResponse:
        try:
            app_status = await CheckAppService.get_instance().invoke()
            
            return LzResponse.from_response_dto_primitives({
                "message": "App status check completed",
                "data": app_status
            })
            
        except Exception as error:
            self.logger.log_exception(error)
            return LzResponse.from_response_dto_primitives({
                "code": HttpResponseCodeEnum.INTERNAL_SERVER_ERROR,
                "message": HttpResponseMessageEnum.INTERNAL_SERVER_ERROR.value
            })