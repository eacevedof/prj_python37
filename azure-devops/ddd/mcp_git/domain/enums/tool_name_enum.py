from enum import Enum
from typing import final


@final
class ToolNameEnum(str, Enum):
    """MCP tool names exposed by the Git server."""

    GIT_CREATE_INTEGRATION_BRANCH = "git_create_integration_branch"
    GIT_LIST_TASK_COMMITS = "git_list_task_commits"
    GIT_SQUASH_TASK_COMMITS = "git_squash_task_commits"
    GIT_PUSH_BRANCH = "git_push_branch"
