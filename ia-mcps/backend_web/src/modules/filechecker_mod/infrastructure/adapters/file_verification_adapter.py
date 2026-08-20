import asyncio
from typing import Any, Self, final

from src.modules.filechecker_mod.application.verify_file_signature.verify_file_signature_dto import (
    VerifyFileSignatureDto,
)
from src.modules.filechecker_mod.application.verify_file_signature.verify_file_signature_service import (
    VerifyFileSignatureService,
)


@final
class FileVerificationAdapter:
    """Implementación del puerto `FileVerification` (filechecker_mcp/domain).

    Sustituye al viejo `VerifyFileSignatureController`, que devolvía un sobre
    `{code, data|error}`: aquí `FileCheckerException` se propaga y quien la
    traduce a texto para el agente es la fachada MCP.

    `asyncio.to_thread` porque el caso de uso lee disco (y puede descargar una
    URL) de forma síncrona: bloquearía el bucle de eventos.
    """

    _verify_file_signature_service: VerifyFileSignatureService

    def __init__(self) -> None:
        self._verify_file_signature_service = VerifyFileSignatureService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def verify_file_signature(self, primitives: dict[str, Any]) -> dict[str, Any]:
        result_dto = await asyncio.to_thread(
            self._verify_file_signature_service, VerifyFileSignatureDto.from_primitives(primitives)
        )
        return result_dto.to_dict()
