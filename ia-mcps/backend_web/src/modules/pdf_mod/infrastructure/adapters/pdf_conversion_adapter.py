import asyncio
from typing import Any, Self, final

from src.modules.pdf_mod.application.convert_md_to_pdf.convert_md_to_pdf_dto import ConvertMdToPdfDto
from src.modules.pdf_mod.application.convert_md_to_pdf.convert_md_to_pdf_service import (
    ConvertMdToPdfService,
)


@final
class PdfConversionAdapter:
    """Implementación del puerto `PdfConversion` (pdf_mcp/domain).

    Sustituye al viejo `ConvertMdToPdfController`, que devolvía un sobre
    `{code, data|error}`: aquí los errores **se propagan** como `ToPdfException`
    y quien decide cómo contárselos al agente es la fachada MCP, que es la única
    capa que captura.

    `asyncio.to_thread` porque renderizar un PDF es CPU y disco: bloquearía el
    bucle de eventos para todos los demás endpoints.
    """

    _convert_md_to_pdf_service: ConvertMdToPdfService

    def __init__(self) -> None:
        self._convert_md_to_pdf_service = ConvertMdToPdfService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def convert_md_to_pdf(self, primitives: dict[str, Any]) -> dict[str, Any]:
        result_dto = await asyncio.to_thread(
            self._convert_md_to_pdf_service, ConvertMdToPdfDto.from_primitives(primitives)
        )
        return result_dto.to_dict()
