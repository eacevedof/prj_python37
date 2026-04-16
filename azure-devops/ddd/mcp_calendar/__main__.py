"""Entry point for running the MCP Calendar server as a module."""

from ddd.mcp_calendar.infrastructure.controllers.mcp_calendar_controller import (
    start_mcp_or_fail,
)

if __name__ == "__main__":
    start_mcp_or_fail()
