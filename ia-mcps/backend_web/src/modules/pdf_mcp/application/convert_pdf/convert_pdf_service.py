from typing import Self, final

from src.modules.shared.domain.enums.validation_message_enum import ValidationMessageEnum
from src.modules.shared.infrastructure.components.schema_validator.schema_validator import SchemaValidator

from src.modules.pdf_mod.domain.enums.pdf_result_key_enum import PdfResultKeyEnum
from src.modules.pdf_mod.infrastructure.adapters.pdf_conversion_adapter import PdfConversionAdapter

from src.modules.pdf_mcp.domain.enums.tool_name_enum import ToolNameEnum
from src.modules.pdf_mcp.domain.exceptions.pdf_mcp_exception import PdfMcpException
from src.modules.pdf_mcp.domain.ports.pdf_conversion import PdfConversion
from src.modules.pdf_mcp.infrastructure.repositories.tools_reader_in_memory_repository import (
    ToolsReaderInMemoryRepository,
)
from src.modules.pdf_mcp.application.convert_pdf.convert_pdf_dto import ConvertPdfDto
from src.modules.pdf_mcp.application.convert_pdf.convert_pdf_result_dto import ConvertPdfResultDto


@final
class ConvertPdfService:
    """Caso de uso de la fachada MCP: ejecutar una tool del servidor de pdf.

    NO tiene lógica de negocio: valida el payload contra el schema publicado,
    enruta al caso de uso de `pdf_mod` a través del puerto y redacta el
    resultado como texto para el agente.
    """

    _schema_validator: SchemaValidator
    _tools_reader_in_memory_repository: ToolsReaderInMemoryRepository
    _pdf_conversion: PdfConversion

    _convert_pdf_dto: ConvertPdfDto

    def __init__(self) -> None:
        self._schema_validator = SchemaValidator.get_instance()
        self._tools_reader_in_memory_repository = ToolsReaderInMemoryRepository.get_instance()
        self._pdf_conversion: PdfConversion = PdfConversionAdapter.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, convert_pdf_dto: ConvertPdfDto) -> ConvertPdfResultDto:
        """Caso de uso: ConvertPdf.

        Returns:
            ConvertPdfResultDto: texto de respuesta para el agente.

        Raises:
            PdfMcpException: si la tool no existe o el payload no cumple el
                inputSchema publicado.
            ToPdfException: la que propague el caso de uso de pdf_mod.
        """
        self._convert_pdf_dto = convert_pdf_dto
        self._fail_if_wrong_input()

        if self._convert_pdf_dto.tool_name == ToolNameEnum.CONVERT_MD_TO_PDF.value:
            text = await self.__get_converted_pdf_text()
        else:
            PdfMcpException.bad_request(f"unknown tool: {self._convert_pdf_dto.tool_name}")

        return ConvertPdfResultDto.from_primitives({
            "tool_name": self._convert_pdf_dto.tool_name,
            "text": text,
        })

    def _fail_if_wrong_input(self) -> None:
        if not self._convert_pdf_dto.tool_name:
            PdfMcpException.bad_request(ValidationMessageEnum.TOOL_NAME_REQUIRED)
        self.__fail_if_payload_breaks_the_published_schema()

    def __fail_if_payload_breaks_the_published_schema(self) -> None:
        input_schema = self._tools_reader_in_memory_repository.get_input_schema_by_tool_name(
            self._convert_pdf_dto.tool_name
        )
        if not input_schema:
            return
        first_error_message = self._schema_validator.get_first_error_message(
            self._convert_pdf_dto.payload_dict, input_schema
        )
        if first_error_message:
            PdfMcpException.bad_request(first_error_message)

    async def __get_converted_pdf_text(self) -> str:
        result = await self._pdf_conversion.convert_md_to_pdf(self._convert_pdf_dto.payload_dict)
        return (
            "PDF generado:\n"
            f"- ruta: {result[PdfResultKeyEnum.PDF_FILE_PATH]}\n"
            f"- tamaño: {result[PdfResultKeyEnum.PDF_SIZE_BYTES]} bytes"
        )
