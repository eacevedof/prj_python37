"""Entry point for running the MCP Hashed Password server as a module."""

from ddd.mcp_hashed_pwd.infrastructure.controllers.mcp_hashed_pwd_controller import (
    start_mcp_or_fail,
)

if __name__ == "__main__":
    start_mcp_or_fail()
