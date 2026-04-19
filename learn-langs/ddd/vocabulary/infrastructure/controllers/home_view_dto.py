"""DTO de vista para el Home."""

from dataclasses import dataclass, field
from typing import Self

from ddd.vocabulary.application.load_home import LoadHomeResultDto, TagItemDto, StatsDto
from ddd.vocabulary.domain.enums import LanguageCodeEnum


@dataclass(slots=True)
class LanguageOptionViewDto:
    """DTO para una opción de idioma en el dropdown."""

    code: str
    display_name: str

    @classmethod
    def from_enum(cls, lang: LanguageCodeEnum) -> Self:
        return cls(code=lang.value, display_name=lang.display_name)


@dataclass(slots=True)
class TagViewDto:
    """DTO para un tag en la vista."""

    id: int
    name: str
    color: str
    is_selected: bool = False

    @classmethod
    def from_item_dto(cls, item: TagItemDto, selected_tags: list[str]) -> Self:
        return cls(
            id=item.id,
            name=item.name,
            color=item.color,
            is_selected=item.name in selected_tags,
        )


@dataclass(slots=True)
class StatsViewDto:
    """DTO para las estadísticas en la vista."""

    total_words: int
    due_for_review: int
    avg_score_percent: int  # Ya calculado como porcentaje

    @classmethod
    def from_stats_dto(cls, stats: StatsDto) -> Self:
        return cls(
            total_words=stats.total_words,
            due_for_review=stats.due_for_review,
            avg_score_percent=int(stats.avg_score * 100),
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
    def initial(cls) -> Self:
        """Crea el DTO inicial con opciones de idioma."""
        return cls(
            language_options=[
                LanguageOptionViewDto.from_enum(lang)
                for lang in LanguageCodeEnum.ui_options()
            ],
            default_lang_code=LanguageCodeEnum.default().value,
            selected_lang_code=LanguageCodeEnum.default().value,
            is_loading=True,
        )

    @classmethod
    def from_result(
        cls,
        result: LoadHomeResultDto,
        selected_lang_code: str,
        selected_tags: list[str],
    ) -> Self:
        """Crea el DTO desde el resultado del servicio."""
        if not result.success:
            return cls(
                language_options=[
                    LanguageOptionViewDto.from_enum(lang)
                    for lang in LanguageCodeEnum.ui_options()
                ],
                default_lang_code=LanguageCodeEnum.default().value,
                selected_lang_code=selected_lang_code,
                is_loading=False,
                error_message=result.error_message,
            )

        return cls(
            language_options=[
                LanguageOptionViewDto.from_enum(lang)
                for lang in LanguageCodeEnum.ui_options()
            ],
            default_lang_code=LanguageCodeEnum.default().value,
            selected_lang_code=selected_lang_code,
            selected_tags=selected_tags,
            tags=[
                TagViewDto.from_item_dto(tag, selected_tags)
                for tag in result.tags
            ],
            stats=StatsViewDto.from_stats_dto(result.stats),
            is_loading=False,
        )
