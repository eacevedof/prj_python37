"""Servicio para obtener imagenes de una palabra."""

from typing import final, Self

from ddd.shared.infrastructure.components.logger import Logger
from ddd.vocabulary.application.get_word_images.get_word_images_dto import (
    GetWordImagesDto,
)
from ddd.vocabulary.application.get_word_images.get_word_images_result_dto import (
    GetWordImagesResultDto,
)
from ddd.vocabulary.infrastructure.repositories import ImagesReaderSqliteRepository


@final
class GetWordImagesService:
    """Servicio para obtener imagenes de una palabra."""

    _images_reader_sqlite_repository: ImagesReaderSqliteRepository

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._images_reader_sqlite_repository = ImagesReaderSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, get_word_images_dto: GetWordImagesDto) -> GetWordImagesResultDto:
        """
        Obtiene todas las imagenes de una palabra.

        Args:
            get_word_images_dto: DTO con el word_id.

        Returns:
            GetWordImagesResultDto con la lista de imagenes.
        """
        word_images = await self._images_reader_sqlite_repository.get_word_es_images_by_word_es_id(
            get_word_images_dto.word_id
        )
        return GetWordImagesResultDto.from_primitives({
            "images": word_images or []
        })
