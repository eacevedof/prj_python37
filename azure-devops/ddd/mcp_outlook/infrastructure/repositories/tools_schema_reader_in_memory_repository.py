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
            self._get_download_attachment_schema(),
            self._get_archive_message_schema(),
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
                        "description": "optional mailbox user principal name or id (e.g., 'requests@contoso.com'); defaults to the OUTLOOK_DEFAULT_MAILBOX env var",
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
                "required": [],
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
                        "description": "optional mailbox user principal name or id (e.g., 'requests@contoso.com'); defaults to the OUTLOOK_DEFAULT_MAILBOX env var",
                    },
                    "message_id": {
                        "type": "string",
                        "description": "graph message id",
                    },
                },
                "required": ["message_id"],
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
                        "description": "optional mailbox user principal name or id (e.g., 'requests@contoso.com'); defaults to the OUTLOOK_DEFAULT_MAILBOX env var",
                    },
                    "message_id": {
                        "type": "string",
                        "description": "graph message id",
                    },
                },
                "required": ["message_id"],
            },
        )

    def _get_download_attachment_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.OUTLOOK_DOWNLOAD_ATTACHMENT.value,
            description="download an outlook message attachment (any file type) and save it to disk using microsoft graph api",
            inputSchema={
                "type": "object",
                "properties": {
                    "mailbox": {
                        "type": "string",
                        "description": "optional mailbox user principal name or id (e.g., 'requests@contoso.com'); defaults to the OUTLOOK_DEFAULT_MAILBOX env var",
                    },
                    "message_id": {
                        "type": "string",
                        "description": "graph message id",
                    },
                    "attachment_id": {
                        "type": "string",
                        "description": "graph attachment id",
                    },
                    "target_dir": {
                        "type": "string",
                        "description": "optional destination folder; defaults to the OUTLOOK_DOWNLOADS_PATH env var",
                    },
                },
                "required": ["message_id", "attachment_id"],
            },
        )

    def _get_archive_message_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.OUTLOOK_ARCHIVE_MESSAGE.value,
            description="archive an outlook message to disk: creates one folder per email ('YYYYMMDD-<subject-slug>') holding the message as email.txt plus every attachment alongside it",
            inputSchema={
                "type": "object",
                "properties": {
                    "mailbox": {
                        "type": "string",
                        "description": "optional mailbox user principal name or id (e.g., 'requests@contoso.com'); defaults to the OUTLOOK_DEFAULT_MAILBOX env var",
                    },
                    "message_id": {
                        "type": "string",
                        "description": "graph message id",
                    },
                    "target_dir": {
                        "type": "string",
                        "description": "optional base folder where the per-email folder is created (typically the client folder, e.g. 'C:/projects/docus/bbva'); defaults to the OUTLOOK_ARCHIVE_PATH env var",
                    },
                },
                "required": ["message_id"],
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
                        "description": "optional mailbox user principal name or id (e.g., 'requests@contoso.com'); defaults to the OUTLOOK_DEFAULT_MAILBOX env var",
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
                "required": ["message_id", "attachment_id"],
            },
        )
