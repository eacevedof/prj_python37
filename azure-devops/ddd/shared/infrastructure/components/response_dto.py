import json
from dataclasses import dataclass, field
from typing import Self, Any

from ddd.shared.domain.enums.response_code_enum import ResponseCodeEnum


@dataclass(frozen=True, slots=True)
class ResponseDto:
    code: int = ResponseCodeEnum.OK
    message: str = ""
    data: Any = field(default_factory=dict)

    @property
    def status(self) -> str:
        response_code = str(self.code)
        if response_code.startswith("2"):
            return "success"
        return "error"

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            code=int(primitives.get("code", ResponseCodeEnum.OK)),
            message=str(primitives.get("message", "")),
            data=primitives.get("data", {}),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "code": self.code,
            "status": self.status,
            "message": self.message,
            "data": self.data,
        }

    def get_as_json(self) -> str:
        return json.dumps(self.to_dict(), ensure_ascii=False)


@dataclass(frozen=True, slots=True)
class SuccessResponseDto(ResponseDto):
    code: int = ResponseCodeEnum.OK

    @classmethod
    def from_data(cls, data: Any, message: str = "") -> Self:
        return cls(code=ResponseCodeEnum.OK, message=message, data=data)


@dataclass(frozen=True, slots=True)
class ErrorResponseDto(ResponseDto):
    code: int = ResponseCodeEnum.BAD_REQUEST

    @classmethod
    def from_error(cls, message: str, code: int = ResponseCodeEnum.BAD_REQUEST) -> Self:
        return cls(code=code, message=message, data={})
