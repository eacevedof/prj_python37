from typing import final, Self, Any

from mcp.types import TextContent

from ddd.shared.infrastructure.components.logger import Logger
from ddd.mcp_local_devops.domain.enums import ToolNameEnum
from ddd.mcp_local_devops.application.call_tool.call_tool_dto import CallToolDto
from ddd.mcp_local_devops.application.call_tool.call_tool_result_dto import CallToolResultDto
from ddd.devops.application import (
    SetupProjectDto,
    SetupProjectService,
    GetNextPortDto,
    GetNextPortService,
)


@final
class CallToolService:
    """Service that routes MCP tool calls to local devops operations."""

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
            if call_tool_dto.event_name == ToolNameEnum.LOCAL_SETUP_PROJECT.value:
                text_contents = await self.__get_setup_project_text_content()

            elif call_tool_dto.event_name == ToolNameEnum.LOCAL_GET_NEXT_PORT.value:
                text_contents = await self.__get_next_port_text_content()

            else:
                text_contents = [
                    TextContent(type="text", text=f"unknown tool: {call_tool_dto.event_name}")
                ]

        except Exception as e:
            self._logger.write_error(
                module="CallToolService.__call__",
                message=str(e),
                context={"tool": call_tool_dto.event_name, "payload": self._payload_dict}
            )
            text_contents = [
                TextContent(type="text", text=f"error: {str(e)}")
            ]

        return CallToolResultDto.from_primitives({
            "contents": text_contents
        })

    async def __get_setup_project_text_content(self) -> list[TextContent]:
        setup_project_result_dto = await SetupProjectService.get_instance()(
            SetupProjectDto.from_primitives(self._payload_dict)
        )

        lines = [
            "project setup completed:",
            f"- project: {setup_project_result_dto.project_name}",
            f"- folder: {setup_project_result_dto.app_folder}",
            f"- path: {setup_project_result_dto.app_path}",
            f"- port: {setup_project_result_dto.port}",
            f"- server_name: {setup_project_result_dto.server_name}",
            f"- database: {setup_project_result_dto.db_name}",
            f"- url: {setup_project_result_dto.url}",
            f"- env_file: {setup_project_result_dto.env_path}",
            "",
            "steps completed:",
        ]
        for step in setup_project_result_dto.steps_completed:
            lines.append(f"  - {step}")

        return [TextContent(type="text", text="\n".join(lines))]

    async def __get_next_port_text_content(self) -> list[TextContent]:
        get_next_port_result_dto = await GetNextPortService.get_instance()(
            GetNextPortDto.from_primitives(self._payload_dict)
        )

        return [TextContent(
            type="text",
            text=f"next available port: {get_next_port_result_dto.port}"
        )]
