from dataclasses import dataclass
from typing import Self, Any


@dataclass(slots=True)
class TagEntity:
    """Entidad: tag para categorizar palabras."""

    id: int
    name: str
    color: str = "#6B7280"
    created_at: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            id=int(primitives.get("id", 0)),
            name=str(primitives.get("name", "")).strip(),
            color=str(primitives.get("color", "#6B7280") or "#6B7280").strip(),
            created_at=str(primitives.get("created_at", "") or ""),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.id,
            "name": self.name,
            "color": self.color,
            "created_at": self.created_at,
        }
