from typing import final, Self

from ddd.shared.infrastructure.components.logger import Logger
from ddd.devops.application.admin_loc_mysql.admin_loc_mysql_dto import AdminLocMysqlDto
from ddd.devops.application.admin_loc_mysql.admin_loc_mysql_result_dto import (
    AdminLocMysqlResultDto,
)
from ddd.devops.infrastructure.repositories import MysqlAdminRepository


@final
class AdminLocMysqlService:
    """Service for local MySQL administration operations."""

    _logger: Logger
    _mysql_admin_repository: MysqlAdminRepository

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._mysql_admin_repository = MysqlAdminRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: AdminLocMysqlDto) -> AdminLocMysqlResultDto:
        self._logger.write_info(
            module="AdminLocMysqlService.__call__",
            message=f"Executing action: {dto.action} - database: {dto.database}, table: {dto.table}",
        )

        match dto.action:
            case "list_databases":
                return await self._list_databases()
            case "show_tables":
                return await self._show_tables(dto.database)
            case "describe_table":
                return await self._describe_table(dto.database, dto.table)
            case "execute_query":
                return await self._execute_query(dto.database, dto.query)
            case _:
                return AdminLocMysqlResultDto.from_primitives(
                    {
                        "action": dto.action,
                        "success": False,
                        "message": f"Unknown action: {dto.action}. Valid actions: list_databases, show_tables, describe_table, execute_query",
                        "data": [],
                        "row_count": 0,
                    }
                )

    async def _list_databases(self) -> AdminLocMysqlResultDto:
        result = await self._mysql_admin_repository.execute_query(
            database="",
            query="SHOW DATABASES",
        )
        return AdminLocMysqlResultDto.from_primitives(
            {
                "action": "list_databases",
                "success": result["success"],
                "message": result["message"],
                "data": result["data"],
                "row_count": result["row_count"],
            }
        )

    async def _show_tables(self, database: str) -> AdminLocMysqlResultDto:
        if not database:
            return AdminLocMysqlResultDto.from_primitives(
                {
                    "action": "show_tables",
                    "success": False,
                    "message": "Database name is required for show_tables action",
                    "data": [],
                    "row_count": 0,
                }
            )

        result = await self._mysql_admin_repository.execute_query(
            database=database,
            query="SHOW TABLES",
        )
        return AdminLocMysqlResultDto.from_primitives(
            {
                "action": "show_tables",
                "success": result["success"],
                "message": result["message"],
                "data": result["data"],
                "row_count": result["row_count"],
            }
        )

    async def _describe_table(
        self, database: str, table: str
    ) -> AdminLocMysqlResultDto:
        if not database:
            return AdminLocMysqlResultDto.from_primitives(
                {
                    "action": "describe_table",
                    "success": False,
                    "message": "Database name is required for describe_table action",
                    "data": [],
                    "row_count": 0,
                }
            )

        if not table:
            return AdminLocMysqlResultDto.from_primitives(
                {
                    "action": "describe_table",
                    "success": False,
                    "message": "Table name is required for describe_table action",
                    "data": [],
                    "row_count": 0,
                }
            )

        result = await self._mysql_admin_repository.execute_query(
            database=database,
            query=f"DESCRIBE `{table}`",
        )
        return AdminLocMysqlResultDto.from_primitives(
            {
                "action": "describe_table",
                "success": result["success"],
                "message": result["message"],
                "data": result["data"],
                "row_count": result["row_count"],
            }
        )

    async def _execute_query(self, database: str, query: str) -> AdminLocMysqlResultDto:
        if not query:
            return AdminLocMysqlResultDto.from_primitives(
                {
                    "action": "execute_query",
                    "success": False,
                    "message": "Query is required for execute_query action",
                    "data": [],
                    "row_count": 0,
                }
            )

        result = await self._mysql_admin_repository.execute_query(
            database=database,
            query=query,
        )
        return AdminLocMysqlResultDto.from_primitives(
            {
                "action": "execute_query",
                "success": result["success"],
                "message": result["message"],
                "data": result["data"],
                "row_count": result["row_count"],
            }
        )
