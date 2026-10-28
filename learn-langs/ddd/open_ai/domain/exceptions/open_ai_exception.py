from typing import final

from ddd.shared.domain.enums.response_code_enum import ResponseCodeEnum


@final
class OpenAIException(Exception):
    """Excepciones del dominio open_ai."""

    _code: int
    _message: str

    def __init__(self, message: str, code: int = ResponseCodeEnum.BAD_REQUEST) -> None:
        self._message = message
        self._code = code
        super().__init__(self._message)

    @property
    def code(self) -> int:
        return self._code

    @property
    def message(self) -> str:
        return self._message

    @classmethod
    def bad_request(cls, message: str) -> "OpenAIException":
        raise cls(message, ResponseCodeEnum.BAD_REQUEST)

    @classmethod
    def not_found(cls, message: str) -> "OpenAIException":
        raise cls(message, ResponseCodeEnum.NOT_FOUND)

    @classmethod
    def unexpected_custom(cls, message: str) -> "OpenAIException":
        raise cls(message, ResponseCodeEnum.INTERNAL_SERVER_ERROR)
