"""DTO de vista para resultado de eliminacion de palabra."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(slots=True)
class DeleteWordViewDto:
    """DTO que el controlador pasa a la vista con el resultado."""

    success: bool
    word_id: int | None = None
    text: str = ""
    images_deleted: int = 0
    translations_deleted: int = 0
    error_message: str | None = None
    error_code: int | None = None

    @classmethod
    def ok(
        cls,
        word_id: int,
        text: str,
        images_deleted: int = 0,
        translations_deleted: int = 0,
    ) -> Self:
        """Crea un DTO de exito."""
        return cls(
            success=True,
            word_id=word_id,
            text=text,
            images_deleted=images_deleted,
            translations_deleted=translations_deleted,
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
    def is_not_found(self) -> bool:
        """Indica si el error es por recurso no encontrado."""
        return self.error_code == 404

    @property
    def message(self) -> str:
        """Mensaje descriptivo del resultado."""
        if self.success:
            parts = [f"Palabra '{self.text}' eliminada"]
            if self.images_deleted > 0:
                parts.append(f"{self.images_deleted} imagenes")
            if self.translations_deleted > 0:
                parts.append(f"{self.translations_deleted} traducciones")
            return ", ".join(parts)
        return self.error_message or "Error desconocido"

    def to_dict(self) -> dict[str, Any]:
        """Convierte a diccionario."""
        return {
            "success": self.success,
            "word_id": self.word_id,
            "text": self.text,
            "images_deleted": self.images_deleted,
            "translations_deleted": self.translations_deleted,
            "error_message": self.error_message,
            "error_code": self.error_code,
        }
