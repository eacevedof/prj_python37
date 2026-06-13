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
            if call_tool_dto.event_name == ToolNameEnum.VERIFY_FILE_SIGNATURE.value:
                text_contents = await self.__verify_file_signature_text_content()
            else:
                text_contents = [
                    TextContent(
                        type="text", text=f"unknown tool: {call_tool_dto.event_name}"
                    )
                ]

        except Exception as e:
            self._logger.log_exception(e, f"CallToolService.__call__: tool={call_tool_dto.event_name}")
            self._logger.log_payload_error(
                self._payload_dict, f"CallToolService.__call__.payload: tool={call_tool_dto.event_name}"
            )
            text_contents = [TextContent(type="text", text=f"error: {str(e)}")]

        return CallToolResultDto.from_primitives({"contents": text_contents})

    async def __verify_file_signature_text_content(self) -> list[TextContent]:
        result = VerifyFileSignatureService.get_instance()(
            VerifyFileSignatureDto.from_primitives(self._payload_dict)
        )

        lines = [
            f"File verification report:\n"
            f"- file_path: {result.file_path}\n"
            f"- source: {result.source}\n"
            f"- file_size: {result.file_size} bytes\n"
            f"- last_modified: {result.last_modified}\n"
            f"- hash_algorithm: {result.algorithm}\n"
            f"- hash_value: {result.hash_value}\n"
        ]

        if result.executable_format:
            lines.append(f"- executable_format: {result.executable_format}")
            if result.executable_version:
                lines.append(f"  version: {result.executable_version}")
            if result.executable_description:
                lines.append(f"  description: {result.executable_description}")
            if result.executable_product_name:
                lines.append(f"  product: {result.executable_product_name}")
            if result.executable_company:
                lines.append(f"  company: {result.executable_company}")
        else:
            lines.append(f"- executable_format: not an executable")

        if result.signature_method:
            lines.append(f"- signature_method: {result.signature_method}")
            lines.append(f"  status: {result.signature_status}")
            if result.signature_signer:
                lines.append(f"  signer: {result.signature_signer}")
        else:
            lines.append(f"- signature: not verified")

        return [TextContent(type="text", text="\n".join(lines))]
