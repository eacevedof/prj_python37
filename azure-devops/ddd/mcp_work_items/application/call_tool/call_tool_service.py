from typing import final, Self, Any

from mcp.types import TextContent

from ddd.shared.infrastructure.components.logger import Logger
from ddd.mcp_work_items.domain.enums import ToolNameEnum
from ddd.mcp_work_items.application.call_tool.call_tool_dto import CallToolDto
from ddd.mcp_work_items.application.call_tool.call_tool_result_dto import CallToolResultDto
from ddd.workitems.application import (
    CreateEpicDto,
    CreateEpicService,
    CreateTaskDto,
    CreateTaskService,
    GetTasksDto,
    GetTasksService,
    UpdateTaskDto,
    UpdateTaskService,
)


@final
class CallToolService:
    """Service that routes MCP tool calls to work item operations."""

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
            if call_tool_dto.event_name == ToolNameEnum.WI_CREATE_EPIC.value:
                text_contents = await self.__get_create_epic_text_content()

            elif call_tool_dto.event_name == ToolNameEnum.WI_CREATE_TASK.value:
                text_contents = await self.__get_create_task_text_content()

            elif call_tool_dto.event_name == ToolNameEnum.WI_GET_TASKS.value:
                text_contents = await self.__get_tasks_as_text_content()

            elif call_tool_dto.event_name == ToolNameEnum.WI_UPDATE_TASK.value:
                text_contents = await self.__get_update_task_text_content()

            else:
                text_contents = [
                    TextContent(type="text", text=f"unknown tool: {call_tool_dto.event_name}")
                ]

        except Exception as e:
            text_contents = [
                TextContent(type="text", text=f"error: {str(e)}")
            ]

        return CallToolResultDto(contents=text_contents)

    async def __get_create_epic_text_content(self) -> list[TextContent]:
        result = await CreateEpicService.get_instance()(
            CreateEpicDto.from_primitives(
                self._payload_dict
            )
        )

        return [TextContent(
            type="text",
            text=f"epic created:\n- id: {result.id}\n- title: {result.title}\n- url: {result.url}"
        )]

    async def __get_create_task_text_content(self) -> list[TextContent]:
        result = await CreateTaskService.get_instance()(
            CreateTaskDto.from_primitives(
                self._payload_dict
            )
        )

        return [TextContent(
            type="text",
            text=(
                f"task created:\n"
                f"- id: {result.id}\n"
                f"- title: {result.title}\n"
                f"- url: {result.url}\n"
                f"- epic_id: {result.epic_id}\n"
                f"- due_date: {result.due_date or 'n/a'}"
            )
        )]

    async def __get_tasks_as_text_content(self) -> list[TextContent]:
        get_tasks_result_dto = await GetTasksService.get_instance()(
            GetTasksDto.from_primitives(self._payload_dict)
        )
        if not get_tasks_result_dto.tasks:
            return [TextContent(type="text", text="no tasks found.")]

        lines = [f"tasks found: {get_tasks_result_dto.total}\n"]
        for task in get_tasks_result_dto.tasks:
            lines.append(
                f"- #{task.id} [{task.state}] {task.title}\n"
                f"  type: {task.work_item_type} | assigned_to: {task.assigned_to or 'n/a'} | due: {task.due_date or 'n/a'}"
            )

        return [TextContent(type="text", text="\n".join(lines))]

    async def __get_update_task_text_content(self) -> list[TextContent]:
        update_task_result_dto = await UpdateTaskService.get_instance()(
            UpdateTaskDto.from_primitives(
                self._payload_dict
            )
        )

        return [TextContent(
            type="text",
            text=(
                f"task updated:\n"
                f"- id: {update_task_result_dto.id}\n"
                f"- title: {update_task_result_dto.title}\n"
                f"- state: {update_task_result_dto.state}\n"
                f"- url: {update_task_result_dto.url}"
            )
        )]
