from dataclasses import dataclass
from typing import final, Any


@final
@dataclass(frozen=True)
class CallToolDto:
    """DTO for calling an MCP tool."""

    event_name: str
    payload_dict: dict[str, Any]

    @classmethod
    def from_primitives(cls, primitives: dict) -> "CallToolDto":
        return cls(
            event_name=primitives["event_name"],
            payload_dict=primitives.get("arguments", {}),
        )
