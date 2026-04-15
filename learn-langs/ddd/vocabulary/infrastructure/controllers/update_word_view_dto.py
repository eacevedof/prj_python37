"""DTO de vista para resultado de actualizacion de palabra."""

from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(slots=True)
class UpdateWordViewDto:
    """DTO que el controlador pasa a la vista con el resultado."""

    success: bool
    word_id: int | None = None
    text: str = ""
    word_type: str = ""
    notes: str = ""
    tags: list[str] = field(default_factory=list)
    translations: dict[str, str] = field(default_factory=dict)
    error_message: str | None = None
    error_code: int | None = None

    @classmethod
    def ok(
        cls,
        word_id: int,
        text: str,
        word_type: str,
        notes: str,
        tags: list[str],
        translations: dict[str, str],
    ) -> Self:
        """Crea un DTO de exito."""
        return cls(
            success=True,
            word_id=word_id,
            text=text,
            word_type=word_type,
            notes=notes,
            tags=tags,
            translations=translations,
        )

    @classmethod
    def error(cls, message: str, code: int = 500) -> Self:
        """Crea un DTO de error."""
        return cls(
            success=False,
            error_message=message,
            error_code=code,
        )

    @property
    def is_conflict(self) -> bool:
        """Indica si el error es por conflicto (ya existe)."""
        return self.error_code == 409

    @property
    def is_validation_error(self) -> bool:
        """Indica si el error es de validacion."""
        return self.error_code == 400

    @property
    def is_not_found(self) -> bool:
        """Indica si el error es por recurso no encontrado."""
        return self.error_code == 404

    def to_dict(self) -> dict[str, Any]:
        """Convierte a diccionario."""
        return {
            "success": self.success,
            "word_id": self.word_id,
            "text": self.text,
            "word_type": self.word_type,
            "notes": self.notes,
            "tags": self.tags,
            "translations": self.translations,
            "error_message": self.error_message,
            "error_code": self.error_code,
        }
