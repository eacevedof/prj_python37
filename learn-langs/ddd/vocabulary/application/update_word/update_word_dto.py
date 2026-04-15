"""DTO de entrada para actualizar una palabra."""

from dataclasses import dataclass, field
from typing import Self, Any

from ddd.vocabulary.domain.enums import WordTypeEnum


@dataclass(frozen=True, slots=True)
class UpdateWordDto:
    """Input DTO para actualizar una palabra en espanol."""

    word_id: int
    text: str
    word_type: str = "WORD"
    notes: str = ""
    tags: list[str] = field(default_factory=list)
    translations: dict[str, str] = field(default_factory=dict)  # lang_code -> text

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        word_type = str(primitives.get("word_type", "WORD")).upper()

        # Validar word_type
        try:
            WordTypeEnum(word_type)
        except ValueError:
            word_type = "WORD"

        return cls(
            word_id=int(primitives.get("word_id", 0)),
            text=str(primitives.get("text", "")).strip(),
            word_type=word_type,
            notes=str(primitives.get("notes", "") or "").strip(),
            tags=list(primitives.get("tags", []) or []),
            translations=dict(primitives.get("translations", {}) or {}),
        )

    def validate(self) -> list[str]:
        """Valida el DTO y retorna lista de errores."""
        errors: list[str] = []

        if self.word_id <= 0:
            errors.append("'word_id' must be a positive integer")

        if not self.text:
            errors.append("'text' cannot be empty")

        if len(self.text) > 500:
            errors.append("'text' cannot exceed 500 characters")

        try:
            WordTypeEnum(self.word_type)
        except ValueError:
            errors.append(f"Invalid word_type: '{self.word_type}'")

        return errors
