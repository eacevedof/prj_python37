"""DTO de vista para actualizacion de palabra."""

from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class UpdateWordViewDto:
    """DTO inmutable que el Controller pasa a la Vista."""

    # Datos del formulario
    form_values: dict[str, Any] = field(default_factory=dict)

    # Tags disponibles para seleccionar
    available_tags: tuple[dict[str, Any], ...] = field(default_factory=tuple)

    # Resultado de operacion
    word_id: int | None = None
    text: str = ""

    # Estado
    is_loading: bool = False
    error_message: str | None = None
    error_field: str | None = None
    success_message: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        tags_raw = primitives.get("available_tags", []) or []
        return cls(
            form_values=dict(primitives.get("form_values", {}) or {}),
            available_tags=tuple(tags_raw),
            word_id=primitives.get("word_id"),
            text=str(primitives.get("text", "")),
            is_loading=bool(primitives.get("is_loading", False)),
            error_message=primitives.get("error_message"),
            error_field=primitives.get("error_field"),
            success_message=primitives.get("success_message"),
        )

    @classmethod
    def loading(cls) -> Self:
        """DTO estado cargando."""
        return cls.from_primitives({"is_loading": True})

    @classmethod
    def with_data(
        cls,
        word_id: int,
        text: str,
        word_type: str,
        notes: str,
        translation_nl: str,
        selected_tags: list[str],
        available_tags: list[dict[str, Any]],
    ) -> Self:
        """DTO con datos cargados para edicion."""
        return cls.from_primitives({
            "word_id": word_id,
            "text": text,
            "form_values": {
                "text_es": text,
                "text_nl": translation_nl,
                "word_type": word_type,
                "notes": notes,
                "selected_tags": selected_tags,
            },
            "available_tags": available_tags,
            "is_loading": False,
        })

    @classmethod
    def success(cls, word_id: int, text: str) -> Self:
        """DTO de exito."""
        return cls.from_primitives({
            "word_id": word_id,
            "text": text,
            "success_message": f"Palabra '{text}' actualizada correctamente",
            "is_loading": False,
        })

    @classmethod
    def error(
        cls,
        message: str,
        form_values: dict[str, Any] | None = None,
        available_tags: list[dict[str, Any]] | None = None,
        error_field: str | None = None,
    ) -> Self:
        """DTO de error."""
        return cls.from_primitives({
            "form_values": form_values or {},
            "available_tags": available_tags or [],
            "error_message": message,
            "error_field": error_field,
            "is_loading": False,
        })

    @property
    def is_success(self) -> bool:
        """Indica si fue exitoso."""
        return self.success_message is not None
