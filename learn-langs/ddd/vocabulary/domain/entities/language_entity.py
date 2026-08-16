from dataclasses import dataclass
from typing import Self, Any


@dataclass(slots=True)
class LanguageEntity:
    """Entidad: idioma disponible."""

    code: str
    name: str
    native_name: str
    flag_emoji: str = ""
    is_active: bool = True
    created_at: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            code=str(primitives.get("code", "")).strip(),
            name=str(primitives.get("name", "")).strip(),
            native_name=str(primitives.get("native_name", "")).strip(),
            flag_emoji=str(primitives.get("flag_emoji", "") or ""),
            is_active=bool(primitives.get("is_active", True)),
            created_at=str(primitives.get("created_at", "") or ""),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "code": self.code,
            "name": self.name,
            "native_name": self.native_name,
            "flag_emoji": self.flag_emoji,
            "is_active": self.is_active,
            "created_at": self.created_at,
        }
