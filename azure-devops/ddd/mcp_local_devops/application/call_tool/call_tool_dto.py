from typing import final, Self, Any
from dataclasses import dataclass


@final
@dataclass(frozen=True)
class CallToolDto:
    """DTO for MCP tool call."""

    event_name: str
    payload_dict: dict[str, Any]

    @classmethod
    def from_primitives(cls, data: dict[str, Any]) -> Self:
        return cls(
            event_name=data.get("event_name", ""),
            payload_dict=data.get("payload_dict", {}),
        )
