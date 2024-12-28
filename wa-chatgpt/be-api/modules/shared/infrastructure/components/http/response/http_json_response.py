
from typing import Dict, Any, final
from dataclasses import dataclass, field
from datetime import datetime
from flask import jsonify, Response

from modules.shared.domain.enums.http_response_code_enum import HttpResponseCodeEnum

@final
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

    def get_as_json_response(self) -> Response:
        response = jsonify(self.__to_dict())
        response.status_code = self.code
        return response

    def __to_dict(self) -> Dict[str, Any]:
        tz = datetime.now().astimezone().tzinfo
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        return {
            "code": self.code,
            "status": self.status,
            "message": self.message,
            "data": self.data,
            "responded_at": f"{now} ({tz})"
        }

