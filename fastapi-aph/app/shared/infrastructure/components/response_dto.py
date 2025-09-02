from typing import Any, Optional, Dict, final
from dataclasses import dataclass


@dataclass(frozen=True)
class ResponseDtoPrimitives:
    code: Optional[int] = None
    message: Optional[str] = None
    data: Optional[Any] = None


@final
@dataclass(frozen=True)
class ResponseDto:
    code: int = 200
    message: str = ""
    data: Any = None
    
    def __post_init__(self) -> None:
        if self.data is None:
            object.__setattr__(self, 'data', [])
    
    @property
    def status(self) -> str:
        response_code = str(self.code)
        return "success" if response_code.startswith("2") else "error"
    
    @classmethod
    def from_primitives(cls, primitives: ResponseDtoPrimitives) -> 'ResponseDto':
        return cls(
            code=primitives.code or 200,
            message=primitives.message or "",
            data=primitives.data or []
        )
    
    def to_primitives(self) -> Dict[str, Any]:
        return {
            "code": self.code,
            "status": self.status,
            "message": self.message,
            "data": self.data,
        }