from dataclasses import dataclass, field
from typing import Any, Self

from mcp.types import TextContent


@dataclass(frozen=True, slots=True)
class CallToolResultDto:
    """Result DTO for MCP call_tool response."""

    contents: list[TextContent] = field(default_factory=list)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        """Construct from tool result."""
        return cls(
            contents=list(primitives.get("contents", [])),
        )

    def to_list(self) -> list[TextContent]:
        """Serialize to MCP TextContent list."""
        return self.contents
