from enum import Enum
from typing import final


@final
class ToolNameEnum(str, Enum):
    """MCP tool names exposed by the PDF server."""

    CONVERT_MD_TO_PDF = "pdf_convert_md_to_pdf"
