"""Servicio para generar imagenes de palabras con IA (DALL-E)."""

from typing import final, Self
import urllib.request
import ssl

from ddd.shared.infrastructure.components.logger import Logger
from ddd.open_ai.infrastructure.repositories import DalleImageReaderRepository
from ddd.vocabulary.application.generate_word_image_ai.generate_word_image_ai_dto import (
    GenerateWordImageAiDto,
)
from ddd.vocabulary.application.generate_word_image_ai.generate_word_image_ai_result_dto import (
    GenerateWordImageAiResultDto,
)
from ddd.vocabulary.domain.entities import WordImageEntity
from ddd.vocabulary.domain.enums import ImageSourceEnum
from ddd.vocabulary.infrastructure.repositories import ImagesWriterSqliteRepository


@final
class GenerateWordImageAiService:
    """Servicio para generar imagenes con DALL-E 3."""

    _instance: "GenerateWordImageAiService | None" = None

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._dalle_image_reader_repository = DalleImageReaderRepository.get_instance()
        self._images_writer_repository = ImagesWriterSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def __call__(
        self,
        generate_word_image_ai_dto: GenerateWordImageAiDto
    ) -> GenerateWordImageAiResultDto:
        """
        Genera una imagen para una palabra usando DALL-E 3.

        Args:
            generate_word_image_ai_dto: DTO con palabra en español, traducción y contexto.

        Returns:
            GenerateWordImageAiResultDto con el resultado.
        """
        try:
            if not generate_word_image_ai_dto.word_es or not generate_word_image_ai_dto.word_lang:
                return GenerateWordImageAiResultDto.error(
                    "Se requiere palabra en español y traducción"
                )

            # Generar imagen con DALL-E (prompt oculto en el repositorio)
            dalle_response = self._dalle_image_reader_repository.get_ai_image_by_word(
                word_es=generate_word_image_ai_dto.word_es,
                word_lang=generate_word_image_ai_dto.word_lang,
                size="1024x1024",
                quality="standard",
                style="vivid",
            )

            dalle_url = dalle_response["url"]
            revised_prompt = dalle_response["revised_prompt"]

            # Descargar imagen
            downloaded_image = self._download_image(dalle_url)

            # Guardar imagen en disco y BD
            word_image_entity = WordImageEntity(
                id=0,
                word_es_id=generate_word_image_ai_dto.word_id,
                source_type=ImageSourceEnum.AI_GENERATED,
                file_path="",
                mime_type="image/png",
                original_url=dalle_url,
                caption=f"{generate_word_image_ai_dto.word_es} - {generate_word_image_ai_dto.word_lang}",
            )

            saved = await self._images_writer_repository.save_image_bytes(word_image_entity, downloaded_image)

            return GenerateWordImageAiResultDto.ok(
                image_id=saved.id,
                word_id=generate_word_image_ai_dto.word_id,
                file_path=saved.file_path,
                dalle_url=dalle_url,
                prompt_used=revised_prompt,
            )

        except Exception as e:
            self._logger.log_error(
                "GenerateWordImageAiService",
                f"Error generando imagen con IA: {e}",
                {"word_id": generate_word_image_ai_dto.word_id, "word_es": generate_word_image_ai_dto.word_es},
            )
            return GenerateWordImageAiResultDto.error(str(e))


    def _download_image(self, url: str) -> bytes:
        """Descarga imagen desde URL."""
        ctx = ssl.create_default_context()
        ctx.check_hostname = False
        ctx.verify_mode = ssl.CERT_NONE

        with urllib.request.urlopen(url, context=ctx, timeout=30) as response:
            return response.read()
