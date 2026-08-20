from typing import Any, Self, final

from src.modules.shared.infrastructure.controllers.abstract_mcp_controller import AbstractMcpController

from src.modules.media_mod.domain.exceptions.open_ai_exception import OpenAIException

from src.modules.media_mcp.domain.enums.mcp_server_name_enum import McpServerNameEnum
from src.modules.media_mcp.domain.exceptions.media_mcp_exception import MediaMcpException
from src.modules.media_mcp.infrastructure.repositories.tools_reader_in_memory_repository import (
    ToolsReaderInMemoryRepository,
)
from src.modules.media_mcp.application.create_media.create_media_dto import CreateMediaDto
from src.modules.media_mcp.application.create_media.create_media_service import CreateMediaService


@final
class CreateMediaController(AbstractMcpController):
    """Endpoint MCP del módulo media (streamable HTTP)."""

    _instance: "CreateMediaController | None" = None

    _create_media_service: CreateMediaService
    _tools_reader_in_memory_repository: ToolsReaderInMemoryRepository

    def __init__(self) -> None:
        super().__init__(McpServerNameEnum.MEDIA.value)
        self._create_media_service = CreateMediaService.get_instance()
        self._tools_reader_in_memory_repository = ToolsReaderInMemoryRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def get_tool_schemas(self) -> list[dict[str, Any]]:
        return self._tools_reader_in_memory_repository.get_all()

    async def get_tool_text(self, tool_name: str, payload_dict: dict[str, Any]) -> str:
        create_media_result_dto = await self._create_media_service(
            CreateMediaDto.from_primitives({
                "tool_name": tool_name,
                "arguments": payload_dict,
            })
        )
        return create_media_result_dto.text

    def get_domain_exception_types(self) -> tuple[type[Exception], ...]:
        return (MediaMcpException, OpenAIException)
