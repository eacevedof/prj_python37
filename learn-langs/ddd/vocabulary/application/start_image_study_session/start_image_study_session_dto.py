"""Input DTO para iniciar sesión de estudio con imágenes."""

from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class StartImageStudySessionDto:
    """Input DTO para iniciar una sesión de estudio con imágenes."""

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

        if self.limit < 1 or self.limit > 100:
            errors.append("'limit' must be between 1 and 100")

        return errors
