from typing import final, Self

from mcp.types import Tool

from ddd.mcp_git.domain.enums import ToolNameEnum


@final
class ToolsSchemaReaderInMemoryRepository:
    """Repository for Git MCP tool schemas."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_all_git_tools(self) -> list[Tool]:
        return [
            self._get_create_integration_branch_schema(),
            self._get_list_task_commits_schema(),
            self._get_squash_task_commits_schema(),
            self._get_push_branch_schema(),
        ]

    def _get_create_integration_branch_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.GIT_CREATE_INTEGRATION_BRANCH.value,
            description="create an integration branch off the base branch for a task using the local git cli",
            inputSchema={
                "type": "object",
                "properties": {
                    "repo_path": {
                        "type": "string",
                        "description": "absolute path to the local git repository",
                    },
                    "task_id": {
                        "type": "integer",
                        "description": "azure devops task id used to name the integration branch",
                    },
                    "title": {
                        "type": "string",
                        "description": "task title, slugged into the branch name",
                    },
                    "base_branch": {
                        "type": "string",
                        "description": "optional base branch (defaults to the repo's main/master)",
                    },
                },
                "required": ["repo_path", "task_id", "title"],
            },
        )

    def _get_list_task_commits_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.GIT_LIST_TASK_COMMITS.value,
            description="list the commits referencing a task between the base and source branches using the local git cli",
            inputSchema={
                "type": "object",
                "properties": {
                    "repo_path": {
                        "type": "string",
                        "description": "absolute path to the local git repository",
                    },
                    "task_id": {
                        "type": "integer",
                        "description": "azure devops task id referenced in the commit messages",
                    },
                    "base_branch": {
                        "type": "string",
                        "description": "optional base branch (defaults to the repo's main/master)",
                    },
                    "source_branch": {
                        "type": "string",
                        "description": "optional source branch to scan (defaults to the current branch)",
                    },
                },
                "required": ["repo_path", "task_id"],
            },
        )

    def _get_squash_task_commits_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.GIT_SQUASH_TASK_COMMITS.value,
            description="squash a task's commits into a single team-formatted commit using the local git cli",
            inputSchema={
                "type": "object",
                "properties": {
                    "repo_path": {
                        "type": "string",
                        "description": "absolute path to the local git repository",
                    },
                    "task_id": {
                        "type": "integer",
                        "description": "azure devops task id referenced in the commit messages",
                    },
                    "title": {
                        "type": "string",
                        "description": "title used for the resulting squashed commit message",
                    },
                    "source_branch": {
                        "type": "string",
                        "description": "branch holding the task's individual commits",
                    },
                    "integration_branch": {
                        "type": "string",
                        "description": "optional integration branch to check out before squashing",
                    },
                    "base_branch": {
                        "type": "string",
                        "description": "optional base branch (defaults to the repo's main/master)",
                    },
                    "commit_type": {
                        "type": "string",
                        "description": "optional conventional commit type (defaults to 'feat')",
                    },
                },
                "required": ["repo_path", "task_id", "title", "source_branch"],
            },
        )

    def _get_push_branch_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.GIT_PUSH_BRANCH.value,
            description="push a branch to azure repos authenticating with the azure pat using the local git cli",
            inputSchema={
                "type": "object",
                "properties": {
                    "repo_path": {
                        "type": "string",
                        "description": "absolute path to the local git repository",
                    },
                    "branch": {
                        "type": "string",
                        "description": "name of the branch to push",
                    },
                    "remote": {
                        "type": "string",
                        "description": "optional remote name (defaults to 'origin')",
                    },
                },
                "required": ["repo_path", "branch"],
            },
        )
