from typing import Any, Dict

from app.shared.infrastructure.components.logger import Logger
from app.shared.infrastructure.components.http.lz_response import LzResponse
from app.shared.infrastructure.enums.http_response_code_enum import HttpResponseCodeEnum
from app.shared.infrastructure.enums.http_response_message_enum import HttpResponseMessageEnum


class NotFoundController:
    @staticmethod
    def get_instance():
        return NotFoundController()
    
    async def invoke(self, lz_request: Dict[str, Any]) -> LzResponse:
        self._log_not_found_request(lz_request)
        
        return LzResponse.from_response_dto_primitives({
            "code": HttpResponseCodeEnum.NOT_FOUND.value,
            "message": HttpResponseMessageEnum.NOT_FOUND.value,
            "data": None,
        })
    
    def _log_not_found_request(self, lz_request: Dict[str, Any]) -> None:
        Logger.get_instance().log_security({
            "request": {
                "method": lz_request.get("method"),
                "url": lz_request.get("url"),
                "url_params": lz_request.get("url_params"),
                "headers": lz_request.get("headers"),
                "body": lz_request.get("body"),
                "user_agent": lz_request.get("user_agent"),
            },
            "response_code": HttpResponseCodeEnum.NOT_FOUND.value
        }, "[not found request]")