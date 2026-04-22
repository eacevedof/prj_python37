"""Servicio para agregar imagen a palabra."""

from pathlib import Path
from typing import final, Self

from ddd.shared.infrastructure.components.logger import Logger
from ddd.vocabulary.application.add_word_image.add_word_image_dto import (
    AddWordImageDto,
)
from ddd.vocabulary.application.add_word_image.add_word_image_result_dto import (
    AddWordImageResultDto,
)
from ddd.vocabulary.domain.entities import WordImageEntity
from ddd.vocabulary.domain.enums import ImageSourceEnum
from ddd.vocabulary.infrastructure.repositories import ImagesWriterSqliteRepository


@final
class AddWordImageService:
    """Servicio para agregar imagenes a palabras."""

    _instance: "AddWordImageService | None" = None

    def __init__(self) -> None:
        self._images_writer = ImagesWriterSqliteRepository.get_instance()
        self._logger = Logger.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def __call__(self, dto: AddWordImageDto) -> AddWordImageResultDto:
        """
        Agrega una imagen a una palabra.

        Args:
            dto: DTO con datos de la imagen (URL o archivo).

        Returns:
            AddWordImageResultDto con el resultado.
        """
        try:
            if dto.source_type == "URL" and dto.url:
                return await self._add_from_url(dto)
            elif dto.source_type == "LOCAL" and dto.file_path:
                return await self._add_from_file(dto)
            else:
                return AddWordImageResultDto.error(
                    "Debe proporcionar URL o archivo"
                )

        except Exception as e:
            self._logger.write_error(
                "AddWordImageService",
                f"Error agregando imagen: {e}",
                {"word_id": dto.word_id, "source_type": dto.source_type},
            )
            return AddWordImageResultDto.error(str(e))

    async def _add_from_url(self, dto: AddWordImageDto) -> AddWordImageResultDto:
        """Agrega imagen desde URL."""
        import urllib.request
        import ssl

        ctx = ssl.create_default_context()
        ctx.check_hostname = False
        ctx.verify_mode = ssl.CERT_NONE

        with urllib.request.urlopen(dto.url, context=ctx, timeout=10) as response:
            image_bytes = response.read()
            content_type = response.headers.get("Content-Type", "image/png")

        mime_type = content_type.split(";")[0].strip()
        if mime_type not in ["image/png", "image/jpeg", "image/gif", "image/webp", "image/svg+xml"]:
            mime_type = "image/png"

        entity = WordImageEntity(
            id=0,
            word_es_id=dto.word_id,
            source_type=ImageSourceEnum.URL,
            file_path="",
            mime_type=mime_type,
            original_url=dto.url,
        )

        saved = await self._images_writer.save_image_bytes(entity, image_bytes)

        return AddWordImageResultDto.ok(
            image_id=saved.id,
            word_id=dto.word_id,
            file_path=saved.file_path,
        )

    async def _add_from_file(self, dto: AddWordImageDto) -> AddWordImageResultDto:
        """Agrega imagen desde archivo local."""
        path = Path(dto.file_path)
        if not path.exists():
            return AddWordImageResultDto.error("Archivo no encontrado")

        image_bytes = path.read_bytes()

        ext = path.suffix.lower()
        mime_map = {
            ".png": "image/png",
            ".jpg": "image/jpeg",
            ".jpeg": "image/jpeg",
            ".gif": "image/gif",
            ".webp": "image/webp",
            ".svg": "image/svg+xml",
            ".bmp": "image/bmp",
        }
        mime_type = mime_map.get(ext, "image/png")

        entity = WordImageEntity(
            id=0,
            word_es_id=dto.word_id,
            source_type=ImageSourceEnum.LOCAL,
            file_path="",
            mime_type=mime_type,
            original_filename=dto.filename,
        )

        saved = await self._images_writer.save_image_bytes(entity, image_bytes)

        return AddWordImageResultDto.ok(
            image_id=saved.id,
            word_id=dto.word_id,
            file_path=saved.file_path,
        )
