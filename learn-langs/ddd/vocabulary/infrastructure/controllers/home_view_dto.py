"""DTO de vista para el Home."""

from dataclasses import dataclass, field
from typing import Self, Any

from ddd.vocabulary.domain.enums import LanguageCodeEnum


@dataclass(slots=True)
class HomeViewDto:
    """DTO que el Controller pasa a la Vista."""

    # Opciones de idioma
    language_options: list[dict[str, str]] = field(default_factory=list)
    default_lang_code: str = ""
    selected_lang_code: str = ""

    # Tags
    tags: list[dict[str, Any]] = field(default_factory=list)
    selected_tags: list[str] = field(default_factory=list)

    # Stats
    stats: dict[str, Any] | None = None

    # Estado
    is_loading: bool = True
    error_message: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            language_options=list(primitives.get("language_options", []) or []),
            default_lang_code=str(primitives.get("default_lang_code", LanguageCodeEnum.default().value)),
            selected_lang_code=str(primitives.get("selected_lang_code", "")),
            tags=list(primitives.get("tags", []) or []),
            selected_tags=list(primitives.get("selected_tags", []) or []),
            stats=primitives.get("stats"),
            is_loading=bool(primitives.get("is_loading", False)),
            error_message=primitives.get("error_message"),
        )

    @classmethod
    def initial(cls) -> Self:
        """DTO inicial con opciones de idioma."""
        return cls.from_primitives({
            "language_options": [
                {"code": lang.value, "display_name": lang.display_name}
                for lang in LanguageCodeEnum.ui_options()
            ],
            "default_lang_code": LanguageCodeEnum.default().value,
            "selected_lang_code": LanguageCodeEnum.default().value,
            "is_loading": True,
        })

    @classmethod
    def ok(
        cls,
        tags: list[dict[str, Any]],
        stats: dict[str, Any],
        selected_lang_code: str,
        selected_tags: list[str],
    ) -> Self:
        """DTO de éxito."""
        # Marcar tags seleccionados
        for tag in tags:
            tag["is_selected"] = tag.get("name", "") in selected_tags

        return cls.from_primitives({
            "language_options": [
                {"code": lang.value, "display_name": lang.display_name}
                for lang in LanguageCodeEnum.ui_options()
            ],
            "default_lang_code": LanguageCodeEnum.default().value,
            "selected_lang_code": selected_lang_code,
            "selected_tags": selected_tags,
            "tags": tags,
            "stats": stats,
            "is_loading": False,
        })

    @classmethod
    def error(cls, message: str, selected_lang_code: str = "") -> Self:
        """DTO de error."""
        return cls.from_primitives({
            "language_options": [
                {"code": lang.value, "display_name": lang.display_name}
                for lang in LanguageCodeEnum.ui_options()
            ],
            "default_lang_code": LanguageCodeEnum.default().value,
            "selected_lang_code": selected_lang_code or LanguageCodeEnum.default().value,
            "is_loading": False,
            "error_message": message,
        })
