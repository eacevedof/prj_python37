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

    _load_home_dto: LoadHomeDto

    _tags_reader_sqlite_repository: TagsReaderSqliteRepository
    _metrics_reader_sqlite_repository: MetricsReaderSqliteRepository
    _words_es_reader_sqlite_repository: WordsEsReaderSqliteRepository

    def __init__(self) -> None:
        self._tags_reader_sqlite_repository = TagsReaderSqliteRepository.get_instance()
        self._metrics_reader_sqlite_repository = MetricsReaderSqliteRepository.get_instance()
        self._words_es_reader_sqlite_repository = WordsEsReaderSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, load_home_dto: LoadHomeDto) -> LoadHomeResultDto:
        """
        Carga tags disponibles y estadísticas para el idioma.

        Args:
            load_home_dto: Datos de entrada con lang_code.

        Returns:
            LoadHomeResultDto con tags y stats.
        """
        self._load_home_dto = load_home_dto

        # Cargar tags
        tags_raw = await self._tags_reader_sqlite_repository.get_all()
        tags = [TagItemDto.from_primitives(t) for t in tags_raw]

        # Cargar estadísticas
        stats_raw = await self._metrics_reader_sqlite_repository.get_stats_for_lang(load_home_dto.lang_code)
        total_words = await self._words_es_reader_sqlite_repository.get_total_words_es_by_word_type()

        stats = StatsDto.from_primitives({
            "total_words": total_words,
            "due_for_review": stats_raw.get("due_for_review", 0),
            "avg_score": stats_raw.get("avg_score", 0.0),
        })

        return LoadHomeResultDto.ok(tags=tags, stats=stats)
