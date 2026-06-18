import os
from typing import final, Self, Any

from mcp.types import TextContent

from ddd.shared.infrastructure.components.logger import Logger
from ddd.mcp_pdf.domain.enums import ToolNameEnum
from ddd.mcp_pdf.application.call_tool.call_tool_dto import CallToolDto
from ddd.mcp_pdf.application.call_tool.call_tool_result_dto import CallToolResultDto
from ddd.to_pdf.infrastructure.controllers.convert_md_to_pdf_controller import ConvertMdToPdfController


@final
class CallToolService:
    """Routes MCP tool calls to PDF conversion operations."""

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
            if call_tool_dto.event_name == ToolNameEnum.CONVERT_MD_TO_PDF.value:
                text_contents = self.__convert_md_to_pdf_text_content()
            else:
                text_contents = [
                    TextContent(type="text", text=f"unknown tool: {call_tool_dto.event_name}")
                ]

        except Exception as call_exception:
            self._logger.log_exception(
                call_exception,
                f"CallToolService.__call__: tool={call_tool_dto.event_name}",
            )
            text_contents = [TextContent(type="text", text=f"error: {str(call_exception)}")]

        return CallToolResultDto.from_primitives({"contents": text_contents})

    def __convert_md_to_pdf_text_content(self) -> list[TextContent]:
        md_file_path = str(self._payload_dict.get("md_file_path", "")).strip()
        output_pdf_path = os.path.splitext(md_file_path)[0] + ".pdf"

        result = ConvertMdToPdfController.get_instance().invoke(
            md_file_path=md_file_path,
            output_pdf_path=output_pdf_path,
        )

        if result.get("code") == 200:
            data = result.get("data", {})
            return [
                TextContent(
                    type="text",
                    text=(
                        f"PDF generated successfully.\n"
                        f"path: {data.get('pdf_file_path')}\n"
                        f"size: {data.get('pdf_size_bytes')} bytes"
                    ),
                )
            ]

        return [TextContent(type="text", text=f"error: {result.get('error', 'unknown error')}")]
