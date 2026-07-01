from enum import Enum
from typing import final


@final
class ToolNameEnum(str, Enum):
    """MCP tool names exposed by the Outlook server."""

    OUTLOOK_LIST_MESSAGES = "outlook_list_messages"
    OUTLOOK_GET_MESSAGE = "outlook_get_message"
    OUTLOOK_LIST_ATTACHMENTS = "outlook_list_attachments"
    OUTLOOK_READ_PDF_ATTACHMENT = "outlook_read_pdf_attachment"
