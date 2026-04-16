import json
from typing import final, Self, Any

from mcp.types import TextContent

from ddd.shared.infrastructure.components.logger import Logger
from ddd.mcp_anubis.domain.enums import ToolNameEnum
from ddd.mcp_anubis.application.call_tool.call_tool_dto import CallToolDto
from ddd.mcp_anubis.application.call_tool.call_tool_result_dto import (
    CallToolResultDto,
)
from ddd.devops.application import (
    RequestAnubisDto,
    RequestAnubisService,
)


@final
class CallToolService:
    """Service that routes MCP tool calls to Anubis API operations."""

    _logger: Logger
    _payload_dict: dict[str, Any]

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._payload_dict = {}

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, call_tool_dto: CallToolDto) -> CallToolResultDto:
        self._payload_dict = call_tool_dto.payload_dict

        try:
            if call_tool_dto.event_name == ToolNameEnum.REQUEST_ANUBIS.value:
                text_contents = await self.__request_anubis_text_content()
            else:
                text_contents = [
                    TextContent(
                        type="text", text=f"unknown tool: {call_tool_dto.event_name}"
                    )
                ]

        except Exception as e:
            self._logger.write_error(
                module="CallToolService.__call__",
                message=str(e),
                context={
                    "tool": call_tool_dto.event_name,
                    "payload": self._payload_dict,
                },
            )
            text_contents = [TextContent(type="text", text=f"error: {str(e)}")]

        return CallToolResultDto.from_primitives({"contents": text_contents})

    async def __request_anubis_text_content(self) -> list[TextContent]:
        result = await RequestAnubisService.get_instance()(
            RequestAnubisDto.from_primitives(self._payload_dict)
        )

        return [
            TextContent(
                type="text",
                text=json.dumps(result.to_dict(), indent=2, ensure_ascii=False),
            )
        ]
