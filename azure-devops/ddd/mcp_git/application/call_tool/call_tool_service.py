from typing import final, Self, Any

from mcp.types import TextContent

from ddd.mcp_git.domain.enums import ToolNameEnum
from ddd.mcp_git.application.call_tool.call_tool_dto import CallToolDto
from ddd.mcp_git.application.call_tool.call_tool_result_dto import CallToolResultDto
from ddd.git.application import (
    CreateIntegrationBranchDto,
    CreateIntegrationBranchService,
    ListTaskCommitsDto,
    ListTaskCommitsService,
    SquashTaskCommitsDto,
    SquashTaskCommitsService,
    PushBranchDto,
    PushBranchService,
)


@final
class CallToolService:
    """Service that routes MCP tool calls to local git operations."""

    _payload_dict: dict[str, Any]

    def __init__(self) -> None:
        self._payload_dict = {}

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, call_tool_dto: CallToolDto) -> CallToolResultDto:
        self._payload_dict = call_tool_dto.payload_dict

        if call_tool_dto.event_name == ToolNameEnum.GIT_CREATE_INTEGRATION_BRANCH.value:
            text_contents = await self.__get_create_integration_branch_text_content()

        elif call_tool_dto.event_name == ToolNameEnum.GIT_LIST_TASK_COMMITS.value:
            text_contents = await self.__get_list_task_commits_text_content()

        elif call_tool_dto.event_name == ToolNameEnum.GIT_SQUASH_TASK_COMMITS.value:
            text_contents = await self.__get_squash_task_commits_text_content()

        elif call_tool_dto.event_name == ToolNameEnum.GIT_PUSH_BRANCH.value:
            text_contents = await self.__get_push_branch_text_content()

        else:
            text_contents = [
                TextContent(type="text", text=f"unknown tool: {call_tool_dto.event_name}")
            ]

        return CallToolResultDto.from_primitives({
            "contents": text_contents
        })

    async def __get_create_integration_branch_text_content(self) -> list[TextContent]:
        result = await CreateIntegrationBranchService.get_instance()(
            CreateIntegrationBranchDto.from_primitives(self._payload_dict)
        )

        return [TextContent(
            type="text",
            text=(
                f"integration branch created:\n"
                f"- branch: {result.branch}\n"
                f"- base_branch: {result.base_branch}\n"
                f"- task_id: {result.task_id}"
            )
        )]

    async def __get_list_task_commits_text_content(self) -> list[TextContent]:
        result = await ListTaskCommitsService.get_instance()(
            ListTaskCommitsDto.from_primitives(self._payload_dict)
        )

        if not result.commits:
            return [TextContent(type="text", text="no task commits found")]

        lines = [f"task commits ({result.total}):\n"]
        for commit in result.commits:
            lines.append(f"- {commit['sha'][:8]} {commit['subject']}")

        return [TextContent(type="text", text="\n".join(lines))]

    async def __get_squash_task_commits_text_content(self) -> list[TextContent]:
        result = await SquashTaskCommitsService.get_instance()(
            SquashTaskCommitsDto.from_primitives(self._payload_dict)
        )

        return [TextContent(
            type="text",
            text=(
                f"squashed {result.squashed_count} commit(s) into {result.commit_sha}:\n\n"
                f"{result.message}"
            )
        )]

    async def __get_push_branch_text_content(self) -> list[TextContent]:
        result = await PushBranchService.get_instance()(
            PushBranchDto.from_primitives(self._payload_dict)
        )

        return [TextContent(
            type="text",
            text=f"pushed branch '{result.branch}' to remote '{result.remote}': {result.pushed}"
        )]
