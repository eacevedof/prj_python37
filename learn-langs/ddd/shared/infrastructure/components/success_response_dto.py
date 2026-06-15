from dataclasses import dataclass
from typing import Self, Any

from ddd.shared.domain.enums.response_code_enum import ResponseCodeEnum
from ddd.shared.infrastructure.components.response_dto import ResponseDto


@dataclass(frozen=True, slots=True)
class SuccessResponseDto(ResponseDto):
    """Response DTO for successful operations (2xx)."""

    code: int = ResponseCodeEnum.OK

    @classmethod
    def from_data(cls, data: Any, message: str = "") -> Self:
        return cls(code=ResponseCodeEnum.OK, message=message, data=data)
