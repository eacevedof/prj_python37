from typing import final, Self, Any

from mcp.types import TextContent

from ddd.shared.infrastructure.components.logger import Logger
from ddd.mcp_sharepoint.domain.enums import ToolNameEnum
from ddd.mcp_sharepoint.application.call_tool.call_tool_dto import CallToolDto
from ddd.mcp_sharepoint.application.call_tool.call_tool_result_dto import CallToolResultDto
from ddd.sharepoint.application import (
    ListFilesDto,
    ListFilesService,
    UploadFileDto,
    UploadFileService,
    DownloadFileDto,
    DownloadFileService,
    DeleteFileDto,
    DeleteFileService,
)


@final
class CallToolService:
    """Service that routes MCP tool calls to SharePoint operations."""

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
            if call_tool_dto.event_name == ToolNameEnum.SP_LIST_FILES.value:
                text_contents = await self.__get_list_files_text_content()

            elif call_tool_dto.event_name == ToolNameEnum.SP_UPLOAD_FILE.value:
                text_contents = await self.__get_upload_file_text_content()

            elif call_tool_dto.event_name == ToolNameEnum.SP_DOWNLOAD_FILE.value:
                text_contents = await self.__get_download_file_text_content()

            elif call_tool_dto.event_name == ToolNameEnum.SP_DELETE_FILE.value:
                text_contents = await self.__get_delete_file_text_content()

            else:
                text_contents = [
                    TextContent(type="text", text=f"unknown tool: {call_tool_dto.event_name}")
                ]

        except Exception as e:
            self._logger.write_error(
                module="CallToolService.__call__",
                message=str(e),
                context={"tool": call_tool_dto.event_name, "payload": self._payload_dict}
            )
            text_contents = [
                TextContent(type="text", text=f"error: {str(e)}")
            ]

        return CallToolResultDto.from_primitives({
            "contents": text_contents
        })

    async def __get_list_files_text_content(self) -> list[TextContent]:
        result = await ListFilesService.get_instance()(
            ListFilesDto.from_primitives(self._payload_dict)
        )

        if not result.items:
            return [TextContent(type="text", text=f"no files found in: {result.folder_path}")]

        lines = [f"files in {result.folder_path} ({result.total} items):\n"]
        for item in result.items:
            item_type = "folder" if item.is_folder else "file"
            size_str = f"{item.size} bytes" if not item.is_folder else ""
            lines.append(
                f"- [{item_type}] {item.name}\n"
                f"  path: {item.path}\n"
                f"  {size_str}{' | ' if size_str else ''}modified: {item.modified_at}"
            )

        return [TextContent(type="text", text="\n".join(lines))]

    async def __get_upload_file_text_content(self) -> list[TextContent]:
        result = await UploadFileService.get_instance()(
            UploadFileDto.from_primitives(self._payload_dict)
        )

        return [TextContent(
            type="text",
            text=(
                f"file uploaded:\n"
                f"- id: {result.id}\n"
                f"- name: {result.name}\n"
                f"- path: {result.path}\n"
                f"- size: {result.size} bytes\n"
                f"- url: {result.web_url}"
            )
        )]

    async def __get_download_file_text_content(self) -> list[TextContent]:
        result = await DownloadFileService.get_instance()(
            DownloadFileDto.from_primitives(self._payload_dict)
        )

        return [TextContent(
            type="text",
            text=(
                f"file downloaded:\n"
                f"- path: {result.file_path}\n"
                f"- size: {result.size} bytes\n"
                f"- content_base64: {result.content_base64[:100]}{'...' if len(result.content_base64) > 100 else ''}"
            )
        )]

    async def __get_delete_file_text_content(self) -> list[TextContent]:
        result = await DeleteFileService.get_instance()(
            DeleteFileDto.from_primitives(self._payload_dict)
        )

        status = "deleted successfully" if result.deleted else "deletion failed"
        return [TextContent(
            type="text",
            text=f"file {result.file_path}: {status}"
        )]
