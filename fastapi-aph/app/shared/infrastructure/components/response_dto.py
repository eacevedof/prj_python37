from typing import Any, Optional, Dict
from dataclasses import dataclass


@dataclass
class ResponseDtoPrimitives:
    code: Optional[int] = None
    message: Optional[str] = None
    data: Optional[Any] = None


class ResponseDto:
    def __init__(self, primitives: ResponseDtoPrimitives):
        self.code = primitives.code or 200
        self.status = self.__get_status_by_code()
        self.message = primitives.message or ""
        self.data = primitives.data or []
    
    def __get_status_by_code(self) -> str:
        response_code = str(self.code)
        return "success" if response_code.startswith("2") else "error"
    
    @classmethod
    def from_primitives(cls, primitives: ResponseDtoPrimitives) -> 'ResponseDto':
        return cls(primitives)
    
    def to_primitives(self) -> Dict[str, Any]:
        return {
            "code": self.code,
            "status": self.status,
            "message": self.message,
            "data": self.data,
        }