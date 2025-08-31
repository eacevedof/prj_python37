from typing import Any, Dict, Optional
from pydantic import BaseModel
from app.shared.infrastructure.enums.http_response_code_enum import HttpResponseCodeEnum
from app.shared.infrastructure.enums.http_response_message_enum import HttpResponseMessageEnum

class LzResponse(BaseModel):
    code: int = HttpResponseCodeEnum.OK
    status: str = "success"
    message: str = HttpResponseMessageEnum.OK.value
    data: Optional[Dict[str, Any]] = None
    
    @classmethod
    def from_response_dto_primitives(cls, response_data: Dict[str, Any]) -> "LzResponse":
        return cls(
            code=response_data.get("code", HttpResponseCodeEnum.OK),
            status=response_data.get("status", "success"),
            message=response_data.get("message", HttpResponseMessageEnum.OK.value),
            data=response_data.get("data")
        )
    
    @classmethod
    def success(cls, message: str = "Success", data: Optional[Dict[str, Any]] = None) -> "LzResponse":
        return cls(
            code=HttpResponseCodeEnum.OK,
            status="success",
            message=message,
            data=data
        )
    
    @classmethod
    def created(cls, message: str = "Created", data: Optional[Dict[str, Any]] = None) -> "LzResponse":
        return cls(
            code=HttpResponseCodeEnum.CREATED,
            status="success", 
            message=message,
            data=data
        )
    
    @classmethod
    def error(cls, code: int, message: str, data: Optional[Dict[str, Any]] = None) -> "LzResponse":
        return cls(
            code=code,
            status="error",
            message=message,
            data=data
        )