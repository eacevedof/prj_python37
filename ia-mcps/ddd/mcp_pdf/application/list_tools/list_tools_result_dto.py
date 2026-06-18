from dataclasses import dataclass, field
from typing import Self, Any

from mcp.types import Tool


@dataclass(frozen=True, slots=True)
class ListToolsResultDto:
    """Output DTO for MCP list_tools handler."""

    tools: list[Tool] = field(default_factory=list)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        tools = primitives.get("tools", [])
        return cls(tools=tools)

    def to_list(self) -> list[Tool]:
        return self.tools
