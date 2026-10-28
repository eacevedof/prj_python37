from typing import final

from src.modules.shared.domain.enums.response_code_enum import ResponseCodeEnum


@final
class MemoryMcpException(Exception):
    """Error controlado de la fachada MCP de memory.

    Cubre lo que falla ANTES de entrar al módulo de negocio (tool desconocida,
    payload que no cumple el inputSchema). Lo del caso de uso sigue siendo
    `MemoryException`.
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
    def bad_request(cls, message: str) -> "MemoryMcpException":
        raise cls(message, ResponseCodeEnum.BAD_REQUEST)
