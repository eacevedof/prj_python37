"""Entry point for running the MCP Outlook server as a module."""

from ddd.mcp_outlook.infrastructure.controllers.mcp_outlook_controller import (
    start_mcp_or_fail,
)

if __name__ == "__main__":
    start_mcp_or_fail()
