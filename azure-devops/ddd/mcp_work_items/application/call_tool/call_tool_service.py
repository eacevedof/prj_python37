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
    SearchWorkItemsDto,
    SearchWorkItemsService,
    GetWorkItemDetailDto,
    GetWorkItemDetailService,
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

            elif call_tool_dto.event_name == ToolNameEnum.WI_SEARCH.value:
                text_contents = await self.__get_search_text_content()

            elif call_tool_dto.event_name == ToolNameEnum.WI_GET_DETAIL.value:
                text_contents = await self.__get_detail_text_content()

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

    async def __get_search_text_content(self) -> list[TextContent]:
        search_result_dto = await SearchWorkItemsService.get_instance()(
            SearchWorkItemsDto.from_primitives(self._payload_dict)
        )

        if not search_result_dto.items:
            return [TextContent(type="text", text="no work items found.")]

        lines = [f"work items found: {search_result_dto.total}\n"]
        for item in search_result_dto.items:
            lines.append(
                f"- #{item.id} [{item.state}] {item.title}\n"
                f"  type: {item.work_item_type} | project: {item.project}\n"
                f"  assigned_to: {item.assigned_to or 'n/a'} | created: {item.created_date} | changed: {item.changed_date}"
            )

        return [TextContent(type="text", text="\n".join(lines))]

    async def __get_detail_text_content(self) -> list[TextContent]:
        detail_result_dto = await GetWorkItemDetailService.get_instance()(
            GetWorkItemDetailDto.from_primitives(self._payload_dict)
        )

        lines = [
            f"work item #{detail_result_dto.id}",
            f"title: {detail_result_dto.title}",
            f"type: {detail_result_dto.work_item_type}",
            f"state: {detail_result_dto.state}",
            f"assigned_to: {detail_result_dto.assigned_to or 'n/a'}",
            f"created: {detail_result_dto.created_date}",
            f"changed: {detail_result_dto.changed_date}",
            f"url: {detail_result_dto.url}",
            "",
            "description:",
            detail_result_dto.description or "(empty)",
        ]

        if detail_result_dto.comments:
            lines.append("")
            lines.append(f"comments ({len(detail_result_dto.comments)}):")
            for comment in detail_result_dto.comments:
                lines.append(f"  [{comment.created_date}] {comment.created_by}:")
                lines.append(f"    {comment.text}")

        return [TextContent(type="text", text="\n".join(lines))]
