from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class CallToolDto:
    event_name: str
    payload_dic: dict[str, Any] = field(default_factory=dict)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            event_name = str(primitives.get("event_name", "")).strip(),
            payload_dic = primitives.get("arguments", {}),
        )
