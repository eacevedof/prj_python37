from typing import final


@final
class MysqlQueryConst:
    """SQL statements used by local MySQL administration."""

    SHOW_DATABASES = "SHOW DATABASES"
    SHOW_TABLES = "SHOW TABLES"
    DESCRIBE_TABLE_TEMPLATE = "DESCRIBE `{table}`"
