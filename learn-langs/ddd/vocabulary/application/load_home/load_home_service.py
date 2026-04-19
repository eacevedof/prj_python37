"""Servicio para cargar datos del home."""

from typing import final, Self

from ddd.vocabulary.application.load_home.load_home_dto import LoadHomeDto
from ddd.vocabulary.application.load_home.load_home_result_dto import (
    LoadHomeResultDto,
    TagItemDto,
    StatsDto,
)
from ddd.vocabulary.infrastructure.repositories import (
    TagsReaderSqliteRepository,
    MetricsReaderSqliteRepository,
    WordsEsReaderSqliteRepository,
)


@final
class LoadHomeService:
    """Servicio para cargar datos del home (tags y estadísticas)."""

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: LoadHomeDto) -> LoadHomeResultDto:
        """
        Carga tags disponibles y estadísticas para el idioma.

        Args:
            dto: Datos de entrada con lang_code.

        Returns:
            LoadHomeResultDto con tags y stats.
        """
        try:
            tags_reader = TagsReaderSqliteRepository.get_instance()
            metrics_reader = MetricsReaderSqliteRepository.get_instance()
            words_reader = WordsEsReaderSqliteRepository.get_instance()

            # Cargar tags
            tags_raw = await tags_reader.get_all()
            tags = [TagItemDto.from_primitives(t) for t in tags_raw]

            # Cargar estadísticas
            stats_raw = await metrics_reader.get_stats_for_lang(dto.lang_code)
            total_words = await words_reader.count()

            stats = StatsDto(
                total_words=total_words,
                due_for_review=int(stats_raw.get("due_for_review", 0) or 0),
                avg_score=float(stats_raw.get("avg_score", 0.0) or 0.0),
            )

            return LoadHomeResultDto.ok(tags=tags, stats=stats)

        except Exception as e:
            return LoadHomeResultDto.error(str(e))
