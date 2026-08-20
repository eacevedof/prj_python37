from dataclasses import dataclass
from typing import Any, Self, final


@final
@dataclass(frozen=True, slots=True)
class CreateMediaResultDto:
    """Salida del caso de uso: el texto que el agente recibe como resultado."""

    tool_name: str
    text: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            tool_name=str(primitives.get("tool_name", "")),
            text=str(primitives.get("text", "")),
        )

    def to_dict(self) -> dict[str, Any]:
        return {"tool_name": self.tool_name, "text": self.text}
