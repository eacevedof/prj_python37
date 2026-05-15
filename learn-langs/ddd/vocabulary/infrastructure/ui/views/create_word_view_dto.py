"""DTO de vista para crear palabra."""

from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class CreateWordViewDto:
    """DTO inmutable que el Controller pasa a la Vista."""

    # Datos del formulario (para restaurar en caso de error)
    form_values: dict[str, Any] = field(default_factory=dict)

    # Tags disponibles para seleccionar
    available_tags: list[dict[str, Any]] = field(default_factory=list)

    # Grupos disponibles para seleccionar
    available_groups: list[dict[str, Any]] = field(default_factory=list)

    # IDs de grupos seleccionados (para pre-seleccionar "generic")
    selected_group_ids: list[int] = field(default_factory=list)

    # Estado
    is_loading: bool = False
    error_message: str | None = None
    error_field: str | None = None  # Campo con error para highlight
    success_message: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            form_values=dict(primitives.get("form_values", {}) or {}),
            available_tags=list(primitives.get("available_tags", []) or []),
            available_groups=list(primitives.get("available_groups", []) or []),
            selected_group_ids=list(primitives.get("selected_group_ids", []) or []),
            is_loading=bool(primitives.get("is_loading", False)),
            error_message=primitives.get("error_message"),
            error_field=primitives.get("error_field"),
            success_message=primitives.get("success_message"),
        )

    @classmethod
    def empty(
        cls,
        available_tags: list[dict[str, Any]] | None = None,
        available_groups: list[dict[str, Any]] | None = None,
        selected_group_ids: list[int] | None = None,
    ) -> Self:
        """DTO para formulario vacío."""
        return cls.from_primitives({
            "available_tags": available_tags or [],
            "available_groups": available_groups or [],
            "selected_group_ids": selected_group_ids or [],
            "form_values": {
                "text_es": "",
                "text_lang": "",
                "word_type": "WORD",
                "notes": "",
                "selected_tags": [],
            },
        })

    @classmethod
    def loading(cls) -> Self:
        """DTO estado cargando."""
        return cls.from_primitives({
            "is_loading": True,
        })

    @classmethod
    def error(
        cls,
        message: str,
        form_values: dict[str, Any],
        available_tags: list[dict[str, Any]] | None = None,
        available_groups: list[dict[str, Any]] | None = None,
        error_field: str | None = None,
    ) -> Self:
        """DTO con error, restaura valores del form."""
        return cls.from_primitives({
            "form_values": form_values,
            "available_tags": available_tags or [],
            "available_groups": available_groups or [],
            "error_message": message,
            "error_field": error_field,
        })

    @classmethod
    def success(
        cls,
        message: str,
        available_tags: list[dict[str, Any]] | None = None,
        available_groups: list[dict[str, Any]] | None = None,
        selected_group_ids: list[int] | None = None,
    ) -> Self:
        """DTO éxito, limpia formulario."""
        return cls.from_primitives({
            "available_tags": available_tags or [],
            "available_groups": available_groups or [],
            "selected_group_ids": selected_group_ids or [],
            "success_message": message,
            "form_values": {
                "text_es": "",
                "text_lang": "",
                "word_type": "WORD",
                "notes": "",
                "selected_tags": [],
            },
        })
