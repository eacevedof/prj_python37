"""Servicio para obtener imagenes de una palabra."""

from typing import final, Self

from ddd.shared.infrastructure.components.logger import Logger
from ddd.vocabulary.application.get_word_images.get_word_images_dto import (
    GetWordImagesDto,
)
from ddd.vocabulary.application.get_word_images.get_word_images_result_dto import (
    GetWordImagesResultDto,
    WordImageDto,
)
from ddd.vocabulary.infrastructure.repositories import ImagesReaderSqliteRepository


@final
class GetWordImagesService:
    """Servicio para obtener imagenes de una palabra."""

    _instance: "GetWordImagesService | None" = None

    def __init__(self) -> None:
        self._images_reader = ImagesReaderSqliteRepository.get_instance()
        self._logger = Logger.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def __call__(self, dto: GetWordImagesDto) -> GetWordImagesResultDto:
        """
        Obtiene todas las imagenes de una palabra.

        Args:
            dto: DTO con el word_id.

        Returns:
            GetWordImagesResultDto con la lista de imagenes.
        """
        try:
            images_raw = await self._images_reader.get_by_word_id(dto.word_id)
            images = [WordImageDto.from_primitives(img) for img in (images_raw or [])]
            return GetWordImagesResultDto.ok(images)

        except Exception as e:
            self._logger.write_error(
                "GetWordImagesService",
                f"Error obteniendo imagenes: {e}",
                {"word_id": dto.word_id},
            )
            return GetWordImagesResultDto.error(str(e))
