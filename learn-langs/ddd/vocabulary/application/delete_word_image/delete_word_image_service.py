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
        self._images_reader = ImagesReaderSqliteRepository.get_instance()
        self._images_writer = ImagesWriterSqliteRepository.get_instance()
        self._logger = Logger.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def __call__(self, dto: DeleteWordImageDto) -> DeleteWordImageResultDto:
        """
        Elimina una imagen.

        Args:
            dto: DTO con el image_id.

        Returns:
            DeleteWordImageResultDto con el resultado.
        """
        try:
            image_data = await self._images_reader.get_by_id(dto.image_id)

            if not image_data:
                return DeleteWordImageResultDto.error(
                    f"Imagen #{dto.image_id} no encontrada"
                )

            entity = WordImageEntity.from_primitives(image_data)
            await self._images_writer.hard_delete(entity)

            return DeleteWordImageResultDto.ok(dto.image_id)

        except Exception as e:
            self._logger.write_error(
                "DeleteWordImageService",
                f"Error eliminando imagen: {e}",
                {"image_id": dto.image_id},
            )
            return DeleteWordImageResultDto.error(str(e))
