from dataclasses import dataclass
from typing import final

from mcp.types import Tool


@final
@dataclass(frozen=True)
class ListToolsResultDto:
    """Result DTO for list_tools operation."""

    tools: list[Tool]

    @classmethod
    def from_primitives(cls, primitives: dict) -> "ListToolsResultDto":
        return cls(tools=primitives["tools"])

    def to_list(self) -> list[Tool]:
        return self.tools
