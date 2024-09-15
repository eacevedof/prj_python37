from dataclasses import dataclass, field
from typing import Dict, Any
from shared.domain.enums import HttpResponseCodeEnum


@dataclass(frozen=True)
class HttpJsonResponse:
    status: str = field(init=False)
    message: str
    code: int
    data: Dict[str, Any]

    def __post_init__(self):
        object.__setattr__(self, "code", self._validate_code(self.code))
        object.__setattr__(self, "status", self._get_status_by_code())

    @staticmethod
    def _validate_code(code: int) -> int:
        if code < 100 or code > 599:
            return HttpResponseCodeEnum.INTERNAL_SERVER_ERROR.value
        return code

    @staticmethod
    def from_primitives(primitives: Dict[str, Any]) -> 'HttpJsonResponse':
        code = int(primitives.get("code", HttpResponseCodeEnum.OK.value))
        message = str(primitives.get("message", ""))
        data = primitives.get("data", {})
        return HttpJsonResponse(message=message, code=code, data=data)

    def _get_status_by_code(self) -> str:
        if str(self.code).startswith("2"):
            return "success"
        return "error"

    def to_dict(self) -> Dict[str, Any]:
        return {
            "code": self.code,
            "status": self.status,
            "message": self.message,
            "data": self.data
        }
