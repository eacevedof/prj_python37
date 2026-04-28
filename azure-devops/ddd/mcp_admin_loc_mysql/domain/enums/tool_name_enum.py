from enum import Enum
from typing import final


@final
class ToolNameEnum(str, Enum):
    """MCP tool names exposed by the admin loc mysql server."""

    MYSQL_LIST_DATABASES = "mysql_list_databases"
    MYSQL_SHOW_TABLES = "mysql_show_tables"
    MYSQL_DESCRIBE_TABLE = "mysql_describe_table"
    MYSQL_EXECUTE_QUERY = "mysql_execute_query"
