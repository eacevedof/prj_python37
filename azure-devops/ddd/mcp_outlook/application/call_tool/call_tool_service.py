from typing import final, Self, Any

from mcp.types import TextContent

from ddd.mcp_outlook.domain.enums import ToolNameEnum
from ddd.mcp_outlook.application.call_tool.call_tool_dto import CallToolDto
from ddd.mcp_outlook.application.call_tool.call_tool_result_dto import CallToolResultDto
from ddd.outlook.application import (
    ListMessagesDto,
    ListMessagesService,
    GetMessageDto,
    GetMessageService,
    ListAttachmentsDto,
    ListAttachmentsService,
)


@final
class CallToolService:
    """Service that routes MCP tool calls to Outlook mail operations."""

    _payload_dict: dict[str, Any]

    def __init__(self) -> None:
        self._payload_dict = {}

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, call_tool_dto: CallToolDto) -> CallToolResultDto:
        self._payload_dict = call_tool_dto.payload_dict

        if call_tool_dto.event_name == ToolNameEnum.OUTLOOK_LIST_MESSAGES.value:
            text_contents = await self.__get_list_messages_text_content()

        elif call_tool_dto.event_name == ToolNameEnum.OUTLOOK_GET_MESSAGE.value:
            text_contents = await self.__get_message_text_content()

        elif call_tool_dto.event_name == ToolNameEnum.OUTLOOK_LIST_ATTACHMENTS.value:
            text_contents = await self.__get_list_attachments_text_content()

        else:
            text_contents = [
                TextContent(type="text", text=f"unknown tool: {call_tool_dto.event_name}")
            ]

        return CallToolResultDto.from_primitives({
            "contents": text_contents
        })

    async def __get_list_messages_text_content(self) -> list[TextContent]:
        result = await ListMessagesService.get_instance()(
            ListMessagesDto.from_primitives(self._payload_dict)
        )

        if not result.messages:
            return [TextContent(type="text", text="no messages found")]

        lines = [f"messages ({result.total}):\n"]
        for message in result.messages:
            unread_flag = "unread" if not message["is_read"] else "read"
            attachment_flag = " | attachments" if message["has_attachments"] else ""
            lines.append(
                f"- [{unread_flag}{attachment_flag}] {message['subject']}\n"
                f"  id: {message['id']}\n"
                f"  from: {message['from']} | received: {message['received']}\n"
                f"  preview: {message['preview']}"
            )

        return [TextContent(type="text", text="\n".join(lines))]

    async def __get_message_text_content(self) -> list[TextContent]:
        result = await GetMessageService.get_instance()(
            GetMessageDto.from_primitives(self._payload_dict)
        )

        return [TextContent(
            type="text",
            text=(
                f"message:\n"
                f"- id: {result.id}\n"
                f"- subject: {result.subject}\n"
                f"- from: {result.from_address}\n"
                f"- to: {', '.join(result.to)}\n"
                f"- received: {result.received}\n"
                f"- has_attachments: {result.has_attachments}\n"
                f"- body:\n{result.body_text}"
            )
        )]

    async def __get_list_attachments_text_content(self) -> list[TextContent]:
        result = await ListAttachmentsService.get_instance()(
            ListAttachmentsDto.from_primitives(self._payload_dict)
        )

        if not result.attachments:
            return [TextContent(type="text", text="no attachments found")]

        lines = [f"attachments ({result.total}):\n"]
        for attachment in result.attachments:
            lines.append(
                f"- {attachment['name']}\n"
                f"  id: {attachment['id']}\n"
                f"  content_type: {attachment['content_type']} | size: {attachment['size']} bytes"
            )

        return [TextContent(type="text", text="\n".join(lines))]
