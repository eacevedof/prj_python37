"""Servicio para obtener tags disponibles."""

from typing import final, Self

from ddd.vocabulary.application.get_tags.get_tags_result_dto import GetTagsResultDto
from ddd.vocabulary.infrastructure.repositories import TagsReaderSqliteRepository


@final
class GetTagsService:
    """Servicio para obtener todos los tags disponibles."""

    _tags_reader_sqlite_repository: TagsReaderSqliteRepository

    def __init__(self) -> None:
        self._tags_reader_sqlite_repository = TagsReaderSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self) -> GetTagsResultDto:
        """
        Obtiene todos los tags disponibles.

        Returns:
            GetTagsResultDto con la lista de tags.
        """
        tags_raw = await self._tags_reader_sqlite_repository.get_all_tags()
        return GetTagsResultDto.from_primitives({
            "tags": tags_raw
        })
