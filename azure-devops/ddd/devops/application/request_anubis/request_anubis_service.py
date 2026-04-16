from typing import final, Self

from ddd.devops.application.request_anubis.request_anubis_dto import RequestAnubisDto
from ddd.devops.application.request_anubis.request_anubis_result_dto import (
    RequestAnubisResultDto,
)
from ddd.devops.infrastructure.repositories.provision_api_repository import (
    ProvisionApiRepository,
)
from ddd.devops.domain.exceptions.devops_exception import DevOpsException


@final
class RequestAnubisService:
    """Service for executing SQL queries against Anubis API.

    Write operations require explicit confirmation.
    """

    def __init__(self) -> None:
        self._repository = ProvisionApiRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self, request_anubis_dto: RequestAnubisDto
    ) -> RequestAnubisResultDto:
        """Execute SQL query against Anubis API.

        For write operations:
        - If not confirmed, returns requires_confirmation=True with the query
        - If confirmed, executes the write operation

        Args:
            request_anubis_dto: Input DTO with SQL and confirmation status.

        Returns:
            RequestAnubisResultDto with query results or confirmation request.

        Raises:
            DevOpsException: If query execution fails or write rejected.
        """
        sql = request_anubis_dto.sql

        if not sql:
            raise DevOpsException.anubis_empty_query()

        is_write = self._repository.is_write_query(sql)

        if is_write and not request_anubis_dto.confirmed:
            return RequestAnubisResultDto.from_primitives(
                {
                    "result": [],
                    "status_code": 0,
                    "requires_confirmation": True,
                    "query": sql,
                }
            )

        response = await self._repository.execute_query(sql)

        return RequestAnubisResultDto.from_primitives(
            {
                "result": response.get("result", []),
                "status_code": response.get("status_code", 200),
                "requires_confirmation": False,
                "query": sql,
            }
        )
