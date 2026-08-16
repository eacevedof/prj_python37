"""Exception for to_pdf module."""

from typing import final

from ddd.shared.domain.enums.response_code_enum import ResponseCodeEnum


@final
class ToPdfException(Exception):
    _code: int
    _message: str

    def __init__(self, message: str, code: int = ResponseCodeEnum.BAD_REQUEST) -> None:
        super().__init__(message)
        self._code = code
        self._message = message

    @property
    def code(self) -> int:
        return self._code

    @property
    def message(self) -> str:
        return self._message

    @classmethod
    def unexpected_custom(cls, message: str) -> "ToPdfException":
        raise cls(f"{message}", ResponseCodeEnum.INTERNAL_SERVER_ERROR)

    @classmethod
    def bad_request_custom(cls, message: str) -> "ToPdfException":
        raise cls(f"{message}", ResponseCodeEnum.BAD_REQUEST)
