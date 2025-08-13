from abc import ABC


class AbstractDomainException(Exception, ABC):
    _message: str
    _code: int

    def __init__(self, message: str) -> None:
        self._message = message
        super().__init__(self._message)

    @property
    def message(self) -> str:
        return self._message

    @property
    def code(self) -> int:
        return self._code
