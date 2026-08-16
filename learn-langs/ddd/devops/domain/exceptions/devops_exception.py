from typing import final

from ddd.shared.domain.enums.response_code_enum import ResponseCodeEnum


@final
class DevopsException(Exception):
    """Excepciones del dominio devops."""

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
    def migrations_path_not_found(cls, path: str) -> "DevopsException":
        raise cls(f"Migrations path does not exist: {path}", ResponseCodeEnum.NOT_FOUND)

    @classmethod
    def migrations_path_not_directory(cls, path: str) -> "DevopsException":
        raise cls(f"Migrations path is not a directory: {path}", ResponseCodeEnum.BAD_REQUEST)
