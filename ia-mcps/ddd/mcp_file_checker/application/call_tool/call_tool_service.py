from typing import final, Self, Any
import json

from mcp.types import TextContent

from ddd.shared.infrastructure.components.logger import Logger
from ddd.mcp_file_checker.domain.enums import ToolNameEnum
from ddd.mcp_file_checker.application.call_tool.call_tool_dto import CallToolDto
from ddd.mcp_file_checker.application.call_tool.call_tool_result_dto import CallToolResultDto
from ddd.file_checker.application import VerifyFileSignatureDto, VerifyFileSignatureService


@final
class CallToolService:
    """Service that routes MCP tool calls to file_checker operations."""

    _logger: Logger
    _payload_dict: dict[str, Any]

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._payload_dict = {}

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, call_tool_dto: CallToolDto) -> CallToolResultDto:
        self._payload_dict = call_tool_dto.payload_dict

        try:
            text_contents = [
                TextContent(
                    type="text", text=f"unknown tool: {call_tool_dto.event_name}"
                )
            ]

            if call_tool_dto.event_name == ToolNameEnum.VERIFY_FILE_SIGNATURE.value:
                text_contents = await self.__verify_file_signature_text_content()

        except Exception as e:
            self._logger.log_exception(e, f"CallToolService.__call__: tool={call_tool_dto.event_name}")
            self._logger.log_payload_error(
                self._payload_dict, f"CallToolService.__call__.payload: tool={call_tool_dto.event_name}"
            )
            text_contents = [TextContent(type="text", text=f"error: {str(e)}")]

        return CallToolResultDto.from_primitives({
            "contents": text_contents
        })


    async def __verify_file_signature_text_content(self) -> list[TextContent]:
        verify_result_dto = VerifyFileSignatureService.get_instance()(
            VerifyFileSignatureDto.from_primitives(self._payload_dict)
        )

        report_data = {
            "file_information": {
                "file_path": verify_result_dto.file_path,
                "source": verify_result_dto.source,
                "file_size": f"{verify_result_dto.file_size} bytes",
                "last_modified": verify_result_dto.last_modified,
            },
            "hash_verification": {
                "algorithm": verify_result_dto.algorithm,
                "hash_value": verify_result_dto.hash_value,
            },
            "executable_information": {
                "format": verify_result_dto.executable_format or "not an executable",
                "version": verify_result_dto.executable_version or "N/A",
                "description": verify_result_dto.executable_description or "N/A",
                "product_name": verify_result_dto.executable_product_name or "N/A",
                "company": verify_result_dto.executable_company or "N/A",
            },
            "digital_signature": {
                "method": verify_result_dto.signature_method or "not verified",
                "status": verify_result_dto.signature_status or "N/A",
                "signer": verify_result_dto.signature_signer or "not available",
            },
        }

        text_content = self.__get_formatted_result_as_string(report_data)
        return [TextContent(type="text", text=text_content)]

    def __get_formatted_result_as_string(self, report_data: dict) -> str:
        lines = ["=== FILE VERIFICATION REPORT ===\n"]

        for section_name, section_data in report_data.items():
            section_title = section_name.replace("_", " ").title()
            lines.append(f"{section_title}:")
            for key, value in section_data.items():
                formatted_key = key.replace("_", " ").replace(" ", "_")
                lines.append(f"  {formatted_key}: {value}")
            lines.append("")

        return "\n".join(lines)
