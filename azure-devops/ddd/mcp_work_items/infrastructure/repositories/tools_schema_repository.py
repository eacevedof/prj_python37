from typing import final, Self

from mcp.types import Tool

from ddd.mcp_work_items.domain.enums import ToolNameEnum


@final
class ToolsSchemaRepository:

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_all_work_items_tools(self) -> list[Tool]:
        return [
            self._get_create_epic_schema(),
            self._get_create_task_schema(),
            self._get_tasks_schema(),
            self._get_update_task_schema(),
            self._get_search_schema(),
            self._get_detail_schema(),
        ]

    def _get_create_epic_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.WI_CREATE_EPIC.value,
            description="create an epic in azure devops",
            inputSchema={
                "type": "object",
                "properties": {
                    "project": {
                        "type": "string",
                        "description": "azure devops project name",
                    },
                    "title": {
                        "type": "string",
                        "description": "epic title",
                    },
                    "description": {
                        "type": "string",
                        "description": "epic description",
                        "default": "",
                    },
                    "assigned_to": {
                        "type": "string",
                        "description": "assigned user email",
                        "default": "",
                    },
                    "tags": {
                        "type": "string",
                        "description": "comma separated tags",
                        "default": "",
                    },
                },
                "required": ["project", "title"],
            },
        )

    def _get_create_task_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.WI_CREATE_TASK.value,
            description="create a task linked to an epic in azure devops. title can end with yyyy-mm-dd for due_date.",
            inputSchema={
                "type": "object",
                "properties": {
                    "project": {
                        "type": "string",
                        "description": "azure devops project name",
                    },
                    "epic_id": {
                        "type": "integer",
                        "description": "parent epic id",
                    },
                    "title": {
                        "type": "string",
                        "description": "task title (can end with yyyy-mm-dd for due date)",
                    },
                    "description": {
                        "type": "string",
                        "description": "task description",
                        "default": "",
                    },
                    "assigned_to": {
                        "type": "string",
                        "description": "assigned user email",
                        "default": "",
                    },
                    "tags": {
                        "type": "string",
                        "description": "comma separated tags",
                        "default": "",
                    },
                },
                "required": ["project", "epic_id", "title"],
            },
        )

    def _get_tasks_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.WI_GET_TASKS.value,
            description="list tasks from azure devops with optional filters",
            inputSchema={
                "type": "object",
                "properties": {
                    "project": {
                        "type": "string",
                        "description": "azure devops project name",
                    },
                    "epic_id": {
                        "type": "integer",
                        "description": "filter by epic id",
                    },
                    "state": {
                        "type": "string",
                        "description": "filter by state (new, active, resolved, closed)",
                    },
                    "assigned_to": {
                        "type": "string",
                        "description": "filter by assigned user",
                    },
                    "work_item_type": {
                        "type": "string",
                        "description": "filter by type (task, bug, etc.)",
                    },
                    "limit": {
                        "type": "integer",
                        "description": "max number of results",
                        "default": 50,
                    },
                },
                "required": ["project"],
            },
        )

    def _get_update_task_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.WI_UPDATE_TASK.value,
            description="update a task in azure devops (state, assigned_to, title)",
            inputSchema={
                "type": "object",
                "properties": {
                    "project": {
                        "type": "string",
                        "description": "azure devops project name",
                    },
                    "task_id": {
                        "type": "integer",
                        "description": "task id to update",
                    },
                    "state": {
                        "type": "string",
                        "description": "new state (new, active, resolved, closed)",
                    },
                    "assigned_to": {
                        "type": "string",
                        "description": "new assigned user",
                    },
                    "title": {
                        "type": "string",
                        "description": "new title",
                    },
                },
                "required": ["project", "task_id"],
            },
        )

    def _get_search_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.WI_SEARCH.value,
            description="search work items by text across all projects in the azure devops organization",
            inputSchema={
                "type": "object",
                "properties": {
                    "search_text": {
                        "type": "string",
                        "description": "text to search for in work items",
                    },
                    "work_item_type": {
                        "type": "string",
                        "description": "filter by work item type (task, bug, epic, issue, feature, user story, etc.)",
                        "default": "",
                    },
                    "limit": {
                        "type": "integer",
                        "description": "max number of results",
                        "default": 30,
                    },
                },
                "required": ["search_text"],
            },
        )

    def _get_detail_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.WI_GET_DETAIL.value,
            description="get work item detail including description and comments",
            inputSchema={
                "type": "object",
                "properties": {
                    "work_item_id": {
                        "type": "integer",
                        "description": "work item id to get details for",
                    },
                    "project": {
                        "type": "string",
                        "description": "azure devops project name",
                    },
                },
                "required": ["work_item_id"],
            },
        )
