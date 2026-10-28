from enum import StrEnum


class MysqlActionEnum(StrEnum):
    """Local MySQL administration action identifiers."""

    LIST_DATABASES = "list_databases"
    SHOW_TABLES = "show_tables"
    DESCRIBE_TABLE = "describe_table"
    EXECUTE_QUERY = "execute_query"
