from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class CallToolDto:
    """Input DTO for MCP call_tool handler."""

    event_name: str = ""
    payload_dict: dict[str, Any] = field(default_factory=dict)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        event_name = str(primitives.get("event_name", "")).strip()
        payload_dict = primitives.get("arguments", {})
        if not isinstance(payload_dict, dict):
            payload_dict = {}
        return cls(event_name=event_name, payload_dict=payload_dict)
