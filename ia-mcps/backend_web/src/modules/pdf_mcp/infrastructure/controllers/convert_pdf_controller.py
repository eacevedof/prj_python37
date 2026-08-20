from typing import Any, Self, final

from src.modules.shared.infrastructure.controllers.abstract_mcp_controller import AbstractMcpController

from src.modules.pdf_mod.domain.exceptions.to_pdf_exception import ToPdfException

from src.modules.pdf_mcp.domain.enums.mcp_server_name_enum import McpServerNameEnum
from src.modules.pdf_mcp.domain.exceptions.pdf_mcp_exception import PdfMcpException
from src.modules.pdf_mcp.infrastructure.repositories.tools_reader_in_memory_repository import (
    ToolsReaderInMemoryRepository,
)
from src.modules.pdf_mcp.application.convert_pdf.convert_pdf_dto import ConvertPdfDto
from src.modules.pdf_mcp.application.convert_pdf.convert_pdf_service import ConvertPdfService


@final
class ConvertPdfController(AbstractMcpController):
    """Endpoint MCP del módulo pdf (streamable HTTP)."""

    _instance: "ConvertPdfController | None" = None

    _convert_pdf_service: ConvertPdfService
    _tools_reader_in_memory_repository: ToolsReaderInMemoryRepository

    def __init__(self) -> None:
        super().__init__(McpServerNameEnum.PDF.value)
        self._convert_pdf_service = ConvertPdfService.get_instance()
        self._tools_reader_in_memory_repository = ToolsReaderInMemoryRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def get_tool_schemas(self) -> list[dict[str, Any]]:
        return self._tools_reader_in_memory_repository.get_all()

    async def get_tool_text(self, tool_name: str, payload_dict: dict[str, Any]) -> str:
        convert_pdf_result_dto = await self._convert_pdf_service(
            ConvertPdfDto.from_primitives({
                "tool_name": tool_name,
                "arguments": payload_dict,
            })
        )
        return convert_pdf_result_dto.text

    def get_domain_exception_types(self) -> tuple[type[Exception], ...]:
        return (PdfMcpException, ToPdfException)
