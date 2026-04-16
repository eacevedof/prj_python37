from dataclasses import dataclass, field
from typing import Self, Any

from mcp.types import TextContent


@dataclass(frozen=True, slots=True)
class CallToolResultDto:
    """Output DTO containing MCP tool execution results."""

    contents: list[TextContent] = field(default_factory=list)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            contents=primitives.get("contents", []),
        )

    def to_list(self) -> list[TextContent]:
        return self.contents
