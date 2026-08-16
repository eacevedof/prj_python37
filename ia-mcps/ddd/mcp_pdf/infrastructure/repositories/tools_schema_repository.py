from typing import final, Self

from mcp.types import Tool

from ddd.mcp_pdf.domain.enums import ToolNameEnum


@final
class ToolsSchemaRepository:
    """Repository for PDF MCP tool schemas."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_all_pdf_tools(self) -> list[Tool]:
        return [
            self._get_convert_md_to_pdf_schema(),
        ]

    def _get_convert_md_to_pdf_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.CONVERT_MD_TO_PDF.value,
            description="convert a local Markdown file to PDF; the PDF is saved in the same directory with the same name",
            inputSchema={
                "type": "object",
                "properties": {
                    "md_file_path": {
                        "type": "string",
                        "description": "absolute path to the Markdown file (e.g., 'C:/projects/docs/guide.md')",
                    },
                },
                "required": ["md_file_path"],
            },
        )
