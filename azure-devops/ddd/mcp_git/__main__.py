"""Entry point for running the MCP Git server as a module."""

from ddd.mcp_git.infrastructure.controllers.mcp_git_controller import (
    start_mcp_or_fail,
)

if __name__ == "__main__":
    start_mcp_or_fail()
