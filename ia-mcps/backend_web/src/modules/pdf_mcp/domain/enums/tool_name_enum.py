from enum import Enum


class ToolNameEnum(str, Enum):
    """Tools que publica el servidor MCP de pdf."""

    CONVERT_MD_TO_PDF = "pdf_convert_md_to_pdf"
