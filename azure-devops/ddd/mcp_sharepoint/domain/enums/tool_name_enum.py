from enum import Enum
from typing import final


@final
class ToolNameEnum(str, Enum):
    """MCP tool names exposed by the SharePoint server."""

    SP_LIST_FILES = "sp_list_files"
    SP_UPLOAD_FILE = "sp_upload_file"
    SP_DOWNLOAD_FILE = "sp_download_file"
    SP_DELETE_FILE = "sp_delete_file"
