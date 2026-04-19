"""DTO de vista para el Home."""

from dataclasses import dataclass, field
from typing import Self, Any

from ddd.vocabulary.domain.enums import LanguageCodeEnum


@dataclass(slots=True)
class LanguageOptionViewDto:
    """DTO para una opción de idioma en el dropdown."""

    code: str
    display_name: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            code=str(primitives.get("code", "")),
            display_name=str(primitives.get("display_name", "")),
        )

    @classmethod
    def from_enum(cls, lang: LanguageCodeEnum) -> Self:
        return cls.from_primitives({
            "code": lang.value,
            "display_name": lang.display_name,
        })


@dataclass(slots=True)
class TagViewDto:
    """DTO para un tag en la vista."""

    id: int
    name: str
    color: str
    is_selected: bool = False

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            id=int(primitives.get("id", 0)),
            name=str(primitives.get("name", "")),
            color=str(primitives.get("color", "#6B7280") or "#6B7280"),
            is_selected=bool(primitives.get("is_selected", False)),
        )


@dataclass(slots=True)
class StatsViewDto:
    """DTO para las estadísticas en la vista."""

    total_words: int = 0
    due_for_review: int = 0
    avg_score_percent: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        avg_score = float(primitives.get("avg_score", 0.0) or 0.0)
        return cls(
            total_words=int(primitives.get("total_words", 0) or 0),
            due_for_review=int(primitives.get("due_for_review", 0) or 0),
            avg_score_percent=int(avg_score * 100),
        )


@dataclass(slots=True)
class HomeViewDto:
    """DTO completo que el Controller pasa a la Vista."""

    # Opciones estáticas
    language_options: list[LanguageOptionViewDto] = field(default_factory=list)
    default_lang_code: str = ""

    # Estado actual
    selected_lang_code: str = ""
    selected_tags: list[str] = field(default_factory=list)

    # Datos cargados
    tags: list[TagViewDto] = field(default_factory=list)
    stats: StatsViewDto | None = None

    # Estado de carga
    is_loading: bool = True
    error_message: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        # Language options
        lang_options_raw = primitives.get("language_options", []) or []
        language_options = [
            LanguageOptionViewDto.from_primitives(opt) if isinstance(opt, dict)
            else LanguageOptionViewDto.from_enum(opt)
            for opt in lang_options_raw
        ]

        # Tags
        tags_raw = primitives.get("tags", []) or []
        selected_tags = list(primitives.get("selected_tags", []) or [])
        tags = [
            TagViewDto.from_primitives({
                **tag,
                "is_selected": tag.get("name", "") in selected_tags,
            }) if isinstance(tag, dict)
            else tag
            for tag in tags_raw
        ]

        # Stats
        stats_raw = primitives.get("stats")
        stats = StatsViewDto.from_primitives(stats_raw) if stats_raw else None

        return cls(
            language_options=language_options,
            default_lang_code=str(primitives.get("default_lang_code", LanguageCodeEnum.default().value)),
            selected_lang_code=str(primitives.get("selected_lang_code", "")),
            selected_tags=selected_tags,
            tags=tags,
            stats=stats,
            is_loading=bool(primitives.get("is_loading", False)),
            error_message=primitives.get("error_message"),
        )

    @classmethod
    def initial(cls) -> Self:
        """Crea el DTO inicial con opciones de idioma."""
        return cls.from_primitives({
            "language_options": LanguageCodeEnum.ui_options(),
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
        """Crea el DTO de éxito."""
        return cls.from_primitives({
            "language_options": LanguageCodeEnum.ui_options(),
            "default_lang_code": LanguageCodeEnum.default().value,
            "selected_lang_code": selected_lang_code,
            "selected_tags": selected_tags,
            "tags": tags,
            "stats": stats,
            "is_loading": False,
        })

    @classmethod
    def error(cls, message: str, selected_lang_code: str = "") -> Self:
        """Crea el DTO de error."""
        return cls.from_primitives({
            "language_options": LanguageCodeEnum.ui_options(),
            "default_lang_code": LanguageCodeEnum.default().value,
            "selected_lang_code": selected_lang_code or LanguageCodeEnum.default().value,
            "is_loading": False,
            "error_message": message,
        })
