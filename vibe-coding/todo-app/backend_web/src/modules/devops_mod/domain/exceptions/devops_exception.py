from typing import NoReturn, final

from src.modules.shared.domain.enums.response_code_enum import ResponseCodeEnum


@final
class DevopsException(Exception):
    """Excepcion del modulo devops. UNA por modulo, siempre.

    Fijate en las factorias de abajo: estan tipadas como que DEVUELVEN la
    excepcion, pero en realidad la LANZAN. Es intencionado y es lo que permite
    escribir la validacion como una lista de guardias legible:

        if not self._create_task_dto.title:
            TasksException.bad_request_custom("title is required")

    ...en vez de `raise TasksException(...)` en cada linea. El sufijo `_custom`
    esta para que se lea distinto de un constructor normal.

    `code` y `message` son propiedades de solo lectura: quien captura la excepcion
    (el controller) las usa para armar la respuesta HTTP sin tener que adivinar
    que codigo toca.
    """

    _code: int
    _message: str

    def __init__(self, message: str, code: int = ResponseCodeEnum.BAD_REQUEST.value) -> None:
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
    def bad_request_custom(cls, message: str) -> NoReturn:
        raise cls(message, ResponseCodeEnum.BAD_REQUEST.value)

    @classmethod
    def not_found_custom(cls, message: str) -> NoReturn:
        raise cls(message, ResponseCodeEnum.NOT_FOUND.value)
