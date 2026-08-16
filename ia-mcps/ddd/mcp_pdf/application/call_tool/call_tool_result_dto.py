from dataclasses import dataclass, field
from typing import Self, Any

from mcp.types import TextContent


@dataclass(frozen=True, slots=True)
class CallToolResultDto:
    """Output DTO for MCP call_tool handler."""

    contents: list[TextContent] = field(default_factory=list)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        contents = primitives.get("contents", [])
        return cls(contents=contents)

    def to_list(self) -> list[TextContent]:
        return self.contents
