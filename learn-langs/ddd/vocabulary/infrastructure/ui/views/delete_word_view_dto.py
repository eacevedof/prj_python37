"""DTO de vista para eliminacion de palabra."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class DeleteWordViewDto:
    """DTO inmutable que el Controller pasa a la Vista."""

    word_id: int | None = None
    text: str = ""
    images_deleted: int = 0
    translations_deleted: int = 0
    is_loading: bool = False
    error_message: str | None = None
    error_code: int | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            word_id=primitives.get("word_id"),
            text=str(primitives.get("text", "")),
            images_deleted=int(primitives.get("images_deleted", 0)),
            translations_deleted=int(primitives.get("translations_deleted", 0)),
            is_loading=bool(primitives.get("is_loading", False)),
            error_message=primitives.get("error_message"),
            error_code=primitives.get("error_code"),
        )

    @classmethod
    def loading(cls) -> Self:
        """DTO estado cargando."""
        return cls.from_primitives({"is_loading": True})

    @classmethod
    def ok(
        cls,
        word_id: int,
        text: str,
        images_deleted: int = 0,
        translations_deleted: int = 0,
    ) -> Self:
        """DTO de exito."""
        return cls.from_primitives({
            "word_id": word_id,
            "text": text,
            "images_deleted": images_deleted,
            "translations_deleted": translations_deleted,
            "is_loading": False,
        })

    @classmethod
    def error(cls, message: str, code: int = 500) -> Self:
        """DTO de error."""
        return cls.from_primitives({
            "error_message": message,
            "error_code": code,
            "is_loading": False,
        })

    @property
    def success(self) -> bool:
        """Indica si fue exitoso."""
        return self.error_message is None and self.word_id is not None

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
