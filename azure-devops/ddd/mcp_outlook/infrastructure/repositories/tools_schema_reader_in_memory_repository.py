from typing import final, Self

from mcp.types import Tool

from ddd.mcp_outlook.domain.enums import ToolNameEnum


@final
class ToolsSchemaReaderInMemoryRepository:
    """Repository for Outlook MCP tool schemas."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_all_outlook_tools(self) -> list[Tool]:
        return [
            self._get_list_messages_schema(),
            self._get_get_message_schema(),
            self._get_list_attachments_schema(),
            self._get_read_pdf_attachment_schema(),
        ]

    def _get_list_messages_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.OUTLOOK_LIST_MESSAGES.value,
            description="list incoming messages from an outlook mailbox using microsoft graph api",
            inputSchema={
                "type": "object",
                "properties": {
                    "mailbox": {
                        "type": "string",
                        "description": "mailbox user principal name or id (e.g., 'requests@contoso.com')",
                    },
                    "folder": {
                        "type": "string",
                        "description": "optional mail folder to scope the listing (e.g., 'inbox')",
                    },
                    "top": {
                        "type": "integer",
                        "description": "maximum number of messages to return",
                        "default": 25,
                    },
                    "unread_only": {
                        "type": "boolean",
                        "description": "if true, only return unread messages",
                        "default": False,
                    },
                    "search": {
                        "type": "string",
                        "description": "optional full-text search query over the messages",
                    },
                },
                "required": ["mailbox"],
            },
        )

    def _get_get_message_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.OUTLOOK_GET_MESSAGE.value,
            description="get a single outlook message with its plain-text body using microsoft graph api",
            inputSchema={
                "type": "object",
                "properties": {
                    "mailbox": {
                        "type": "string",
                        "description": "mailbox user principal name or id (e.g., 'requests@contoso.com')",
                    },
                    "message_id": {
                        "type": "string",
                        "description": "graph message id",
                    },
                },
                "required": ["mailbox", "message_id"],
            },
        )

    def _get_list_attachments_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.OUTLOOK_LIST_ATTACHMENTS.value,
            description="list attachments metadata of an outlook message using microsoft graph api",
            inputSchema={
                "type": "object",
                "properties": {
                    "mailbox": {
                        "type": "string",
                        "description": "mailbox user principal name or id (e.g., 'requests@contoso.com')",
                    },
                    "message_id": {
                        "type": "string",
                        "description": "graph message id",
                    },
                },
                "required": ["mailbox", "message_id"],
            },
        )

    def _get_read_pdf_attachment_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.OUTLOOK_READ_PDF_ATTACHMENT.value,
            description="download a pdf attachment of an outlook message and extract its text using microsoft graph api",
            inputSchema={
                "type": "object",
                "properties": {
                    "mailbox": {
                        "type": "string",
                        "description": "mailbox user principal name or id (e.g., 'requests@contoso.com')",
                    },
                    "message_id": {
                        "type": "string",
                        "description": "graph message id",
                    },
                    "attachment_id": {
                        "type": "string",
                        "description": "graph attachment id",
                    },
                },
                "required": ["mailbox", "message_id", "attachment_id"],
            },
        )
