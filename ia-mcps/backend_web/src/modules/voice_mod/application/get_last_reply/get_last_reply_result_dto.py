from dataclasses import dataclass
from typing import Any, Self, final


@final
@dataclass(frozen=True, slots=True)
class GetLastReplyResultDto:
    """Salida: el texto (markdown) de la última respuesta, vacío si no la hay."""

    reply_text: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(reply_text=str(primitives.get("reply_text", "")))
