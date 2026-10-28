"""Input DTO para guardar el estado de una actividad (retomar sesión)."""

from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class SaveActivityStateDto:
    """Estado de la actividad en curso (Aprendizaje / Examen con imágenes)."""

    activity: str
    lang_code: str
    tags: list[str] = field(default_factory=list)
    group_id: int | None = None
    word_es_id: int = 0
    word_index: int = 0
    total_words: int = 0
    is_random_order: bool = False

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        group_id_raw = primitives.get("group_id")

        return cls(
            activity=str(primitives.get("activity", "")).strip(),
            lang_code=str(primitives.get("lang_code", "")).strip(),
            tags=list(primitives.get("tags", []) or []),
            group_id=int(group_id_raw) if group_id_raw is not None else None,
            word_es_id=int(primitives.get("word_es_id", 0)),
            word_index=int(primitives.get("word_index", 0)),
            total_words=int(primitives.get("total_words", 0)),
            is_random_order=bool(primitives.get("is_random_order", False)),
        )

    def validate(self) -> list[str]:
        """Valida el DTO y retorna lista de errores."""
        errors: list[str] = []

        if not self.activity:
            errors.append("'activity' is required")

        if not self.lang_code:
            errors.append("'lang_code' is required")

        return errors
