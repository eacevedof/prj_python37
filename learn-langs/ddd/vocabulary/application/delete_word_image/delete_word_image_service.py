"""Servicio para eliminar imagen de palabra."""

from typing import final, Self

from ddd.shared.infrastructure.components.logger import Logger
from ddd.vocabulary.application.delete_word_image.delete_word_image_dto import (
    DeleteWordImageDto,
)
from ddd.vocabulary.application.delete_word_image.delete_word_image_result_dto import (
    DeleteWordImageResultDto,
)
from ddd.vocabulary.domain.entities import WordImageEntity
from ddd.vocabulary.infrastructure.repositories import (
    ImagesReaderSqliteRepository,
    ImagesWriterSqliteRepository,
)


@final
class DeleteWordImageService:
    """Servicio para eliminar imagenes de palabras."""

    _instance: "DeleteWordImageService | None" = None

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._images_reader_sqlite_repository_sqlite_repository = ImagesReaderSqliteRepository.get_instance()
        self._images_writer_sqlite_repository_sqlite_repository = ImagesWriterSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def __call__(self, delete_word_image_dto: DeleteWordImageDto) -> DeleteWordImageResultDto:
        """
        Elimina una imagen.

        Args:
            delete_word_image_dto: DTO con el image_id.

        Returns:
            DeleteWordImageResultDto con el resultado.
        """

        image_data = await self._images_reader_sqlite_repository.get_word_es_image_by_word_es_image_id(delete_word_image_dto.image_id)

        if not image_data:
            return DeleteWordImageResultDto.error(
                f"Imagen #{delete_word_image_dto.image_id} no encontrada"
            )

        entity = WordImageEntity.from_primitives(image_data)
        await self._images_writer_sqlite_repository.hard_delete(entity)

        return DeleteWordImageResultDto.ok(delete_word_image_dto.image_id)
