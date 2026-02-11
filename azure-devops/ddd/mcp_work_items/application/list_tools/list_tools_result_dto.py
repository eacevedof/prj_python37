from dataclasses import dataclass, field
from typing import Self, Any

from mcp.types import Tool


@dataclass(frozen=True, slots=True)
class ListToolsResultDto:
    tools: list[Tool] = field(default_factory=list)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            tools=primitives.get("tools", []),
        )

    def to_list(self) -> list[Tool]:
        return self.tools
