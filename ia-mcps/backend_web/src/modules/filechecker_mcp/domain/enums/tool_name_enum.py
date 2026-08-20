from enum import Enum


class ToolNameEnum(str, Enum):
    """Tools que publica el servidor MCP de file_checker."""

    VERIFY_FILE_SIGNATURE = "file_checker_verify_file_signature"
