from typing import NoReturn, final

from src.modules.shared.domain.enums.response_code_enum import ResponseCodeEnum


@final
class {{Modulo}}Exception(Exception):
    """Excepcion del modulo {{modulo}}. UNA por modulo."""

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

    # LANZAN, aunque esten tipadas como NoReturn: eso permite escribir la
    # validacion como una lista de guardias.
    @classmethod
    def bad_request_custom(cls, message: str) -> NoReturn:
        raise cls(message, ResponseCodeEnum.BAD_REQUEST)

    @classmethod
    def not_found_custom(cls, message: str) -> NoReturn:
        raise cls(message, ResponseCodeEnum.NOT_FOUND)

    @classmethod
    def conflict_custom(cls, message: str) -> NoReturn:
        raise cls(message, ResponseCodeEnum.CONFLICT)
