"""Entry point for running the MCP Anubis server as a module."""

from ddd.mcp_anubis.infrastructure.controllers.mcp_anubis_controller import (
    start_mcp_or_fail,
)

if __name__ == "__main__":
    start_mcp_or_fail()
