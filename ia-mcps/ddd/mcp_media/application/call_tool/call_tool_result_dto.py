from dataclasses import dataclass
from typing import final

from mcp.types import TextContent


@final
@dataclass(frozen=True)
class CallToolResultDto:
    """Result DTO for call_tool operation."""

    contents: list[TextContent]

    @classmethod
    def from_primitives(cls, primitives: dict) -> "CallToolResultDto":
        return cls(contents=primitives["contents"])

    def to_list(self) -> list[TextContent]:
        return self.contents
