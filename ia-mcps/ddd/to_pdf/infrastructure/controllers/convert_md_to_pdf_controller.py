"""Controller for the convert_md_to_pdf use case."""

from typing import final

from ddd.shared.domain.enums.response_code_enum import ResponseCodeEnum
from ddd.shared.infrastructure.components.logger import Logger

from ddd.to_pdf.application import ConvertMdToPdfDto, ConvertMdToPdfService
from ddd.to_pdf.domain.exceptions.to_pdf_exception import ToPdfException


@final
class ConvertMdToPdfController:
    """Controller that exposes the ConvertMdToPdf use case to MCP/HTTP."""

    _logger: Logger
    _convert_md_to_pdf_service: ConvertMdToPdfService

    @classmethod
    def get_instance(cls) -> "ConvertMdToPdfController":
        return cls()

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._convert_md_to_pdf_service = ConvertMdToPdfService.get_instance()

    def invoke(self, md_file_path: str, output_pdf_path: str) -> dict:
        try:
            result_dto = self._convert_md_to_pdf_service(
                ConvertMdToPdfDto.from_primitives({
                    "md_file_path": md_file_path,
                    "output_pdf_path": output_pdf_path,
                })
            )

            return {
                "code": ResponseCodeEnum.OK,
                "data": {
                    "pdf_file_path": result_dto.pdf_file_path,
                    "pdf_size_bytes": result_dto.pdf_size_bytes,
                },
            }

        except ToPdfException as to_pdf_exception:
            self._logger.log_error(
                "ConvertMdToPdfController",
                f"Conversion failed: {to_pdf_exception.message}",
                {"md_file_path": md_file_path, "output_pdf_path": output_pdf_path},
            )
            return {
                "code": to_pdf_exception.code,
                "error": to_pdf_exception.message,
            }

        except Exception as unexpected_exception:
            self._logger.log_exception(unexpected_exception, "ConvertMdToPdfController.invoke")
            return {
                "code": ResponseCodeEnum.INTERNAL_SERVER_ERROR,
                "error": "Internal server error",
            }
