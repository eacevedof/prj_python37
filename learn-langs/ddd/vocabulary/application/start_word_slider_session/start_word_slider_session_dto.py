"""Input DTO para iniciar sesión de slider (presentación auto-reproducida)."""

from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class StartWordSliderSessionDto:
    """Input DTO para iniciar una sesión de slider."""

    lang_code: str
    tags: list[str] = field(default_factory=list)
    group_id: int | None = None
    limit: int = 20

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        group_id_raw = primitives.get("group_id")
        group_id = int(group_id_raw) if group_id_raw is not None else None

        return cls(
            lang_code=str(primitives.get("lang_code", "")).strip(),
            tags=list(primitives.get("tags", []) or []),
            group_id=group_id,
            limit=int(primitives.get("limit", 20)),
        )

    def validate(self) -> list[str]:
        """Valida el DTO y retorna lista de errores."""
        errors: list[str] = []

        if not self.lang_code:
            errors.append("'lang_code' is required")

        if self.limit < 1 or self.limit > 1000:
            errors.append("'limit' must be between 1 and 1000")

        return errors
