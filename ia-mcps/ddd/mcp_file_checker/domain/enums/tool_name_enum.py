from enum import Enum
from typing import final


@final
class ToolNameEnum(str, Enum):
    """MCP tool names exposed by the file_checker server."""

    VERIFY_FILE_SIGNATURE = "file_checker_verify_file_signature"
