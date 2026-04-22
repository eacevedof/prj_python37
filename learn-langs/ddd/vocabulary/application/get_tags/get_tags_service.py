"""Servicio para obtener tags disponibles."""

from typing import final, Self

from ddd.shared.infrastructure.components.logger import Logger
from ddd.vocabulary.application.get_tags.get_tags_result_dto import (
    GetTagsResultDto,
    TagDto,
)
from ddd.vocabulary.infrastructure.repositories import TagsReaderSqliteRepository


@final
class GetTagsService:
    """Servicio para obtener todos los tags disponibles."""

    _instance: "GetTagsService | None" = None

    def __init__(self) -> None:
        self._tags_reader = TagsReaderSqliteRepository.get_instance()
        self._logger = Logger.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def __call__(self) -> GetTagsResultDto:
        """
        Obtiene todos los tags disponibles.

        Returns:
            GetTagsResultDto con la lista de tags.
        """
        try:
            tags_raw = await self._tags_reader.get_all()
            tags = [TagDto.from_primitives(t) for t in tags_raw]
            return GetTagsResultDto.ok(tags)

        except Exception as e:
            self._logger.write_error(
                "GetTagsService",
                f"Error obteniendo tags: {e}",
            )
            return GetTagsResultDto.error(str(e))
