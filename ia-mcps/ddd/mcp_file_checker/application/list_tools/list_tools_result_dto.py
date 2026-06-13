from dataclasses import dataclass, field
from typing import Any, Self

from mcp.types import Tool


@dataclass(frozen=True, slots=True)
class ListToolsResultDto:
    """Result DTO for MCP list_tools response."""

    tools: list[Tool] = field(default_factory=list)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        """Construct from tool schemas."""
        return cls(
            tools=list(primitives.get("tools", [])),
        )

    def to_list(self) -> list[Tool]:
        """Serialize to MCP Tool list."""
        return self.tools
