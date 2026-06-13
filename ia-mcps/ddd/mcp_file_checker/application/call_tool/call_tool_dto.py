from dataclasses import dataclass, field
from typing import Any, Self


@dataclass(frozen=True, slots=True)
class CallToolDto:
    """Input DTO for MCP call_tool request."""

    event_name: str
    payload_dict: dict[str, Any] = field(default_factory=dict)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        """Construct from MCP call_tool event."""
        return cls(
            event_name=str(primitives.get("event_name", "")),
            payload_dict=dict(primitives.get("arguments", {})),
        )
