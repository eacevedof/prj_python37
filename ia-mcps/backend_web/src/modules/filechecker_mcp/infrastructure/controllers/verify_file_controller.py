from typing import Any, Self, final

from src.modules.shared.infrastructure.controllers.abstract_mcp_controller import AbstractMcpController

from src.modules.filechecker_mod.domain.exceptions.file_checker_exception import FileCheckerException

from src.modules.filechecker_mcp.domain.enums.mcp_server_name_enum import McpServerNameEnum
from src.modules.filechecker_mcp.domain.exceptions.filechecker_mcp_exception import (
    FilecheckerMcpException,
)
from src.modules.filechecker_mcp.application.get_tool_schemas.get_tool_schemas_service import (
    GetToolSchemasService,
)
from src.modules.filechecker_mcp.application.verify_file.verify_file_dto import VerifyFileDto
from src.modules.filechecker_mcp.application.verify_file.verify_file_service import VerifyFileService


@final
class VerifyFileController(AbstractMcpController):
    """Endpoint MCP del módulo file_checker (streamable HTTP)."""

    _instance: "VerifyFileController | None" = None

    _verify_file_service: VerifyFileService
    _get_tool_schemas_service: GetToolSchemasService

    def __init__(self) -> None:
        super().__init__(McpServerNameEnum.FILE_CHECKER.value)
        self._verify_file_service = VerifyFileService.get_instance()
        self._get_tool_schemas_service = GetToolSchemasService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def get_tool_schemas(self) -> list[dict[str, Any]]:
        return self._get_tool_schemas_service().tool_schemas

    async def get_tool_text(self, tool_name: str, payload_dict: dict[str, Any]) -> str:
        verify_file_result_dto = await self._verify_file_service(
            VerifyFileDto.from_primitives({
                "tool_name": tool_name,
                "arguments": payload_dict,
            })
        )
        return verify_file_result_dto.text

    def get_domain_exception_types(self) -> tuple[type[Exception], ...]:
        return (FilecheckerMcpException, FileCheckerException)
