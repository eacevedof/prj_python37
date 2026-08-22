from typing import Any, Self, final

from src.modules.shared.infrastructure.controllers.abstract_mcp_controller import AbstractMcpController

from src.modules.emt_mod.domain.exceptions.emt_exception import EmtException
from src.modules.users_mod.domain.exceptions.users_exception import UsersException

from src.modules.emt_mcp.domain.enums.mcp_server_name_enum import McpServerNameEnum
from src.modules.emt_mcp.domain.exceptions.emt_mcp_exception import EmtMcpException
from src.modules.emt_mcp.application.get_tool_schemas.get_tool_schemas_service import (
    GetToolSchemasService,
)
from src.modules.emt_mcp.application.query_emt.query_emt_dto import QueryEmtDto
from src.modules.emt_mcp.application.query_emt.query_emt_service import QueryEmtService


@final
class QueryEmtController(AbstractMcpController):
    """Endpoint MCP del módulo emt (streamable HTTP)."""

    _instance: "QueryEmtController | None" = None

    _query_emt_service: QueryEmtService
    _get_tool_schemas_service: GetToolSchemasService

    def __init__(self) -> None:
        super().__init__(McpServerNameEnum.EMT.value)
        self._query_emt_service = QueryEmtService.get_instance()
        self._get_tool_schemas_service = GetToolSchemasService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def get_tool_schemas(self) -> list[dict[str, Any]]:
        return self._get_tool_schemas_service().tool_schemas

    async def get_tool_text(self, tool_name: str, payload_dict: dict[str, Any]) -> str:
        query_emt_result_dto = await self._query_emt_service(
            QueryEmtDto.from_primitives({
                "tool_name": tool_name,
                "arguments": payload_dict,
            })
        )
        return query_emt_result_dto.text

    def get_domain_exception_types(self) -> tuple[type[Exception], ...]:
        # `UsersException` viene de OTRO bounded context (users_mod), pero llega
        # hasta aquí por las tools de favoritos: si no se declarara, un "no
        # autorizado" saldría como error inesperado 500 en vez de contárselo al
        # agente.
        return (EmtMcpException, EmtException, UsersException)
