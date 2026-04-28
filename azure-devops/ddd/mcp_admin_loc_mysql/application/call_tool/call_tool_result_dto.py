from typing import final, Self, Any
from dataclasses import dataclass

from mcp.types import TextContent


@final
@dataclass(frozen=True)
class CallToolResultDto:
    """Result DTO for MCP tool call."""

    contents: list[TextContent]

    @classmethod
    def from_primitives(cls, data: dict[str, Any]) -> Self:
        return cls(
            contents=data.get("contents", []),
        )
