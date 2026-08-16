from dataclasses import dataclass
from typing import Self

from ddd.shared.domain.enums.response_code_enum import ResponseCodeEnum
from ddd.shared.infrastructure.components.response_dto import ResponseDto


@dataclass(frozen=True, slots=True)
class ErrorResponseDto(ResponseDto):
    """Response DTO for error operations (4xx, 5xx)."""

    code: int = ResponseCodeEnum.BAD_REQUEST

    @classmethod
    def from_error(cls, message: str, code: int = ResponseCodeEnum.BAD_REQUEST) -> Self:
        return cls(code=code, message=message, data={})
