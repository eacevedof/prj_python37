from typing import NoReturn, final

from src.modules.shared.domain.enums.response_code_enum import ResponseCodeEnum


@final
class ListsException(Exception):
    """Excepcion del modulo lists. UNA por modulo, sin excepciones.

    ¿Por que una sola y no una por cada tipo de error? Porque el codigo HTTP ya
    distingue el tipo, y una jerarquia de diez excepciones obligaria a cada
    controller a capturar diez cosas. Con una, el controller tiene un solo
    `except ListsException` y saca el codigo de la propia excepcion.

    Las factorias LANZAN, y estan tipadas como `NoReturn` para decirselo tambien a
    mypy. Eso permite escribir la validacion como una lista de guardias:

        if not self._create_list_dto.name:
            ListsException.bad_request_custom("name es obligatorio")

    ...y ademas hace que despues de una guardia mypy sepa que el codigo no sigue.
    Sin `NoReturn`, esto daria un falso error de tipos:

        if list_row is None:
            ListsException.not_found_custom("no existe")
        return list_row["name"]      # mypy: "list_row podria ser None"

    Cuando cual usar:
        bad_request_custom  400  el cliente mando algo mal (falta un campo, formato invalido)
        not_found_custom    404  lo que pide no existe
        conflict_custom     409  existe, pero choca con una regla (nombre repetido,
                                 borrar algo que aun tiene dependencias)
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

    @classmethod
    def conflict_custom(cls, message: str) -> NoReturn:
        raise cls(message, ResponseCodeEnum.CONFLICT.value)
