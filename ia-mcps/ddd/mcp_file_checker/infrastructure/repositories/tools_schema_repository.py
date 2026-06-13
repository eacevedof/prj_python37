from typing import final, Self

from mcp.types import Tool

from ddd.mcp_file_checker.domain.enums import ToolNameEnum


@final
class ToolsSchemaRepository:
    """Repository for file_checker MCP tool schemas."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_all_file_checker_tools(self) -> list[Tool]:
        return [
            self._get_verify_file_signature_schema(),
        ]

    def _get_verify_file_signature_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.VERIFY_FILE_SIGNATURE.value,
            description="verify file integrity: calculate hash, extract metadata, detect executable format, check digital signature",
            inputSchema={
                "type": "object",
                "properties": {
                    "file_path_or_url": {
                        "type": "string",
                        "description": "local file path or HTTP/HTTPS URL to download (e.g., '/path/to/file.exe' or 'https://example.com/file.zip')",
                    },
                    "algorithm": {
                        "type": "string",
                        "description": "hash algorithm: md5, sha1, sha256 (default), sha512",
                        "enum": ["md5", "sha1", "sha256", "sha512"],
                        "default": "sha256",
                    },
                },
                "required": ["file_path_or_url"],
            },
        )
