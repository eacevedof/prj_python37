from dataclasses import dataclass, field
from typing import Any, Self, final


@final
@dataclass(frozen=True, slots=True)
class ManageMemoryDto:
    """Entrada del caso de uso: una llamada a tool del servidor MCP de memory."""

    tool_name: str
    payload_dict: dict[str, Any] = field(default_factory=dict)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        payload_dict = primitives.get("arguments")
        return cls(
            tool_name=str(primitives.get("tool_name", "")).strip(),
            payload_dict=payload_dict if isinstance(payload_dict, dict) else {},
        )
