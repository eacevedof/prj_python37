from typing import final

from src.modules.shared.domain.enums.response_code_enum import ResponseCodeEnum


@final
class UsersException(Exception):
    """Excepciones del dominio de usuarios (identidad, roles y acceso).

    Viaja hasta el controller del módulo que la provoque —hoy
    `QueryEmtController`, que la declara entre sus excepciones controladas— y de
    ahí sale como texto para el agente.
    """

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
    def bad_request_custom(cls, message: str) -> "UsersException":
        raise cls(f"{message}", ResponseCodeEnum.BAD_REQUEST)

    @classmethod
    def unauthorized_custom(cls, message: str) -> "UsersException":
        raise cls(f"{message}", ResponseCodeEnum.UNAUTHORIZED)

    @classmethod
    def forbidden_custom(cls, message: str) -> "UsersException":
        raise cls(f"{message}", ResponseCodeEnum.FORBIDDEN)

    @classmethod
    def conflict_custom(cls, message: str) -> "UsersException":
        raise cls(f"{message}", ResponseCodeEnum.CONFLICT)
