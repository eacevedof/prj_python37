from typing import final, Self

from mcp.types import Tool

from ddd.mcp_calendar.domain.enums import ToolNameEnum


@final
class ToolsSchemaRepository:
    """Repository for Calendar MCP tool schemas."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_all_calendar_tools(self) -> list[Tool]:
        return [
            self._get_list_events_schema(),
            self._get_get_event_schema(),
            self._get_create_event_schema(),
            self._get_update_event_schema(),
            self._get_delete_event_schema(),
        ]

    def _get_list_events_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.CAL_LIST_EVENTS.value,
            description="list calendar events for a user using microsoft graph api",
            inputSchema={
                "type": "object",
                "properties": {
                    "user_id": {
                        "type": "string",
                        "description": "user id or email (UPN) to get calendar events for",
                    },
                    "start_datetime": {
                        "type": "string",
                        "description": "ISO 8601 start datetime for date range filter (optional, e.g., '2024-01-01T00:00:00')",
                    },
                    "end_datetime": {
                        "type": "string",
                        "description": "ISO 8601 end datetime for date range filter (optional, e.g., '2024-01-31T23:59:59')",
                    },
                    "top": {
                        "type": "integer",
                        "description": "maximum number of events to return (default: 50)",
                        "default": 50,
                    },
                },
                "required": ["user_id"],
            },
        )

    def _get_get_event_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.CAL_GET_EVENT.value,
            description="get a specific calendar event by id using microsoft graph api",
            inputSchema={
                "type": "object",
                "properties": {
                    "user_id": {
                        "type": "string",
                        "description": "user id or email (UPN) who owns the calendar",
                    },
                    "event_id": {
                        "type": "string",
                        "description": "the event id to retrieve",
                    },
                },
                "required": ["user_id", "event_id"],
            },
        )

    def _get_create_event_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.CAL_CREATE_EVENT.value,
            description="create a new calendar event using microsoft graph api",
            inputSchema={
                "type": "object",
                "properties": {
                    "user_id": {
                        "type": "string",
                        "description": "user id or email (UPN) who owns the calendar",
                    },
                    "subject": {
                        "type": "string",
                        "description": "event subject/title",
                    },
                    "start_datetime": {
                        "type": "string",
                        "description": "ISO 8601 start datetime (e.g., '2024-01-15T09:00:00')",
                    },
                    "end_datetime": {
                        "type": "string",
                        "description": "ISO 8601 end datetime (e.g., '2024-01-15T10:00:00')",
                    },
                    "time_zone": {
                        "type": "string",
                        "description": "timezone for the event (default: 'UTC')",
                        "default": "UTC",
                    },
                    "body": {
                        "type": "string",
                        "description": "event body/description (HTML supported)",
                    },
                    "location": {
                        "type": "string",
                        "description": "event location display name",
                    },
                    "attendees": {
                        "type": "string",
                        "description": "comma-separated list of attendee email addresses",
                    },
                    "is_all_day": {
                        "type": "boolean",
                        "description": "whether this is an all-day event (default: false)",
                        "default": False,
                    },
                    "sensitivity": {
                        "type": "string",
                        "description": "event sensitivity: normal, personal, private, confidential (default: 'normal')",
                        "default": "normal",
                    },
                },
                "required": ["user_id", "subject", "start_datetime", "end_datetime"],
            },
        )

    def _get_update_event_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.CAL_UPDATE_EVENT.value,
            description="update an existing calendar event using microsoft graph api",
            inputSchema={
                "type": "object",
                "properties": {
                    "user_id": {
                        "type": "string",
                        "description": "user id or email (UPN) who owns the calendar",
                    },
                    "event_id": {
                        "type": "string",
                        "description": "the event id to update",
                    },
                    "subject": {
                        "type": "string",
                        "description": "new event subject/title",
                    },
                    "start_datetime": {
                        "type": "string",
                        "description": "new ISO 8601 start datetime",
                    },
                    "end_datetime": {
                        "type": "string",
                        "description": "new ISO 8601 end datetime",
                    },
                    "time_zone": {
                        "type": "string",
                        "description": "new timezone for the event",
                    },
                    "body": {
                        "type": "string",
                        "description": "new event body/description (HTML supported)",
                    },
                    "location": {
                        "type": "string",
                        "description": "new event location display name",
                    },
                    "attendees": {
                        "type": "string",
                        "description": "new comma-separated list of attendee email addresses",
                    },
                    "is_all_day": {
                        "type": "boolean",
                        "description": "whether this is an all-day event",
                    },
                    "sensitivity": {
                        "type": "string",
                        "description": "event sensitivity: normal, personal, private, confidential",
                    },
                },
                "required": ["user_id", "event_id"],
            },
        )

    def _get_delete_event_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.CAL_DELETE_EVENT.value,
            description="delete a calendar event using microsoft graph api",
            inputSchema={
                "type": "object",
                "properties": {
                    "user_id": {
                        "type": "string",
                        "description": "user id or email (UPN) who owns the calendar",
                    },
                    "event_id": {
                        "type": "string",
                        "description": "the event id to delete",
                    },
                },
                "required": ["user_id", "event_id"],
            },
        )
