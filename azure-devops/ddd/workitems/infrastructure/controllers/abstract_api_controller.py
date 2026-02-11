from abc import ABC, abstractmethod
from typing import Any

from ddd.shared.domain.enums.response_code_enum import ResponseCodeEnum
from ddd.shared.infrastructure.components.response_dto import (
    ResponseDto,
    SuccessResponseDto,
    ErrorResponseDto,
)


class AbstractApiController(ABC):

    @abstractmethod
    async def __call__(self, *args: Any, **kwargs: Any) -> ResponseDto:
        pass

    def _response_ok(self, data: Any, message: str = "") -> SuccessResponseDto:
        return SuccessResponseDto.from_data(data=data, message=message)

    def _response_created(self, data: Any, message: str = "") -> ResponseDto:
        return ResponseDto(
            code=ResponseCodeEnum.CREATED,
            message=message,
            data=data,
        )

    def _response_error(
        self, message: str, code: int = ResponseCodeEnum.BAD_REQUEST
    ) -> ErrorResponseDto:
        return ErrorResponseDto.from_error(message=message, code=code)

    def _response_error_500(self) -> ErrorResponseDto:
        return ErrorResponseDto.from_error(
            message="Internal server error",
            code=ResponseCodeEnum.INTERNAL_SERVER_ERROR,
        )
