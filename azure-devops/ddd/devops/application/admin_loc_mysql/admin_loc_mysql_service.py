from typing import final, Self

from ddd.shared.infrastructure.components.logger import Logger
from ddd.devops.domain.enums.mysql_action_enum import MysqlActionEnum
from ddd.devops.domain.enums.mysql_query_const import MysqlQueryConst
from ddd.devops.application.admin_loc_mysql.admin_loc_mysql_dto import AdminLocMysqlDto
from ddd.devops.application.admin_loc_mysql.admin_loc_mysql_result_dto import (
    AdminLocMysqlResultDto,
)
from ddd.devops.domain.exceptions.devops_exception import DevOpsException
from ddd.devops.infrastructure.repositories import MysqlAdminReaderMysqlRepository


@final
class AdminLocMysqlService:
    """Service for local MySQL administration operations."""

    _logger: Logger
    _mysql_admin_reader_mysql_repository: MysqlAdminReaderMysqlRepository

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._mysql_admin_reader_mysql_repository = (
            MysqlAdminReaderMysqlRepository.get_instance()
        )

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: AdminLocMysqlDto) -> AdminLocMysqlResultDto:
        self._logger.write_info(
            module="AdminLocMysqlService.__call__",
            message=f"Executing action: {dto.action} - database: {dto.database}, table: {dto.table}",
        )

        match dto.action:
            case MysqlActionEnum.LIST_DATABASES.value:
                return await self._list_databases()
            case MysqlActionEnum.SHOW_TABLES.value:
                return await self._show_tables(dto.database)
            case MysqlActionEnum.DESCRIBE_TABLE.value:
                return await self._describe_table(dto.database, dto.table)
            case MysqlActionEnum.EXECUTE_QUERY.value:
                return await self._execute_query(dto.database, dto.query)
            case _:
                raise DevOpsException.unknown_action(dto.action)

    async def _list_databases(self) -> AdminLocMysqlResultDto:
        result = await self._mysql_admin_reader_mysql_repository.execute_query(
            database="",
            query=MysqlQueryConst.SHOW_DATABASES,
        )
        return AdminLocMysqlResultDto.from_primitives(
            {
                "action": MysqlActionEnum.LIST_DATABASES.value,
                "success": result["success"],
                "message": result["message"],
                "data": result["data"],
                "row_count": result["row_count"],
            }
        )

    async def _show_tables(self, database: str) -> AdminLocMysqlResultDto:
        if not database:
            raise DevOpsException.database_required(MysqlActionEnum.SHOW_TABLES.value)

        result = await self._mysql_admin_reader_mysql_repository.execute_query(
            database=database,
            query=MysqlQueryConst.SHOW_TABLES,
        )
        return AdminLocMysqlResultDto.from_primitives(
            {
                "action": MysqlActionEnum.SHOW_TABLES.value,
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
            raise DevOpsException.database_required(MysqlActionEnum.DESCRIBE_TABLE.value)

        if not table:
            raise DevOpsException.table_required(MysqlActionEnum.DESCRIBE_TABLE.value)

        result = await self._mysql_admin_reader_mysql_repository.execute_query(
            database=database,
            query=MysqlQueryConst.DESCRIBE_TABLE_TEMPLATE.format(table=table),
        )
        return AdminLocMysqlResultDto.from_primitives(
            {
                "action": MysqlActionEnum.DESCRIBE_TABLE.value,
                "success": result["success"],
                "message": result["message"],
                "data": result["data"],
                "row_count": result["row_count"],
            }
        )

    async def _execute_query(self, database: str, query: str) -> AdminLocMysqlResultDto:
        if not query:
            raise DevOpsException.query_required(MysqlActionEnum.EXECUTE_QUERY.value)

        result = await self._mysql_admin_reader_mysql_repository.execute_query(
            database=database,
            query=query,
        )
        return AdminLocMysqlResultDto.from_primitives(
            {
                "action": MysqlActionEnum.EXECUTE_QUERY.value,
                "success": result["success"],
                "message": result["message"],
                "data": result["data"],
                "row_count": result["row_count"],
            }
        )
