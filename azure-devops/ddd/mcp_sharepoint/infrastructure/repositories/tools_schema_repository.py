from typing import final, Self

from mcp.types import Tool

from ddd.mcp_sharepoint.domain.enums import ToolNameEnum


@final
class ToolsSchemaRepository:
    """Repository for SharePoint MCP tool schemas."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_all_sharepoint_tools(self) -> list[Tool]:
        return [
            self._get_list_files_schema(),
            self._get_upload_file_schema(),
            self._get_download_file_schema(),
            self._get_delete_file_schema(),
        ]

    def _get_list_files_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.SP_LIST_FILES.value,
            description="list files and folders in a sharepoint folder using microsoft graph api",
            inputSchema={
                "type": "object",
                "properties": {
                    "folder_path": {
                        "type": "string",
                        "description": "folder path in sharepoint (e.g., '/' for root, '/Documents/subfolder')",
                        "default": "/",
                    },
                    "site_id": {
                        "type": "string",
                        "description": "sharepoint site id (optional, uses default from env if not provided)",
                    },
                },
                "required": [],
            },
        )

    def _get_upload_file_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.SP_UPLOAD_FILE.value,
            description="upload a file to sharepoint using microsoft graph api",
            inputSchema={
                "type": "object",
                "properties": {
                    "file_path": {
                        "type": "string",
                        "description": "destination path in sharepoint including filename (e.g., '/Documents/report.pdf')",
                    },
                    "content_base64": {
                        "type": "string",
                        "description": "file content encoded as base64 string",
                    },
                    "site_id": {
                        "type": "string",
                        "description": "sharepoint site id (optional, uses default from env if not provided)",
                    },
                },
                "required": ["file_path", "content_base64"],
            },
        )

    def _get_download_file_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.SP_DOWNLOAD_FILE.value,
            description="download a file from sharepoint using microsoft graph api",
            inputSchema={
                "type": "object",
                "properties": {
                    "file_path": {
                        "type": "string",
                        "description": "path to the file in sharepoint (e.g., '/Documents/report.pdf')",
                    },
                    "site_id": {
                        "type": "string",
                        "description": "sharepoint site id (optional, uses default from env if not provided)",
                    },
                },
                "required": ["file_path"],
            },
        )

    def _get_delete_file_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.SP_DELETE_FILE.value,
            description="delete a file from sharepoint using microsoft graph api",
            inputSchema={
                "type": "object",
                "properties": {
                    "file_path": {
                        "type": "string",
                        "description": "path to the file in sharepoint (e.g., '/Documents/report.pdf')",
                    },
                    "site_id": {
                        "type": "string",
                        "description": "sharepoint site id (optional, uses default from env if not provided)",
                    },
                },
                "required": ["file_path"],
            },
        )
