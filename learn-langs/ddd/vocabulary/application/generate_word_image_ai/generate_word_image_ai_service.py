"""Servicio para generar imagenes de palabras con IA (DALL-E)."""

from typing import final, Self
import urllib.request
import ssl

from ddd.shared.infrastructure.components.logger import Logger
from ddd.open_ai.infrastructure.repositories import (
    DalleImageGeneratorRepository,
    DallePromptBuilderRepository,
)
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
        self._images_writer = ImagesWriterSqliteRepository.get_instance()
        self._prompt_builder = DallePromptBuilderRepository.get_instance()
        self._image_generator = DalleImageGeneratorRepository.get_instance()
        self._logger = Logger.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def __call__(self, dto: GenerateWordImageAiDto) -> GenerateWordImageAiResultDto:
        """
        Genera una imagen para una palabra usando DALL-E 3.

        Args:
            dto: DTO con palabra en español, traducción y contexto.

        Returns:
            GenerateWordImageAiResultDto con el resultado.
        """
        try:
            if not dto.word_es or not dto.word_lang:
                return GenerateWordImageAiResultDto.error(
                    "Se requiere palabra en español y traducción"
                )

            # Generar prompt optimizado usando el repositorio
            prompt = self._prompt_builder.get_image_prompt(
                word_es=dto.word_es,
                word_lang=dto.word_lang,
                lang_code=dto.lang_code,
                context=dto.context,
                style_override=dto.style_prompt,
            )

            # Generar imagen con DALL-E usando el repositorio
            dalle_response = self._image_generator.generate_image(
                prompt=prompt,
                size="1024x1024",
                quality="standard",
                style="vivid",
            )

            dalle_url = dalle_response["url"]

            # Descargar imagen
            image_bytes = self._download_image(dalle_url)

            # Guardar imagen en disco y BD
            entity = WordImageEntity(
                id=0,
                word_es_id=dto.word_id,
                source_type=ImageSourceEnum.AI_GENERATED,
                file_path="",
                mime_type="image/png",
                original_url=dalle_url,
                caption=f"{dto.word_es} - {dto.word_lang}",
            )

            saved = await self._images_writer.save_image_bytes(entity, image_bytes)

            return GenerateWordImageAiResultDto.ok(
                image_id=saved.id,
                word_id=dto.word_id,
                file_path=saved.file_path,
                dalle_url=dalle_url,
                prompt_used=prompt,
            )

        except Exception as e:
            self._logger.log_error(
                "GenerateWordImageAiService",
                f"Error generando imagen con IA: {e}",
                {"word_id": dto.word_id, "word_es": dto.word_es},
            )
            return GenerateWordImageAiResultDto.error(str(e))

    def _download_image(self, url: str) -> bytes:
        """Descarga imagen desde URL."""
        ctx = ssl.create_default_context()
        ctx.check_hostname = False
        ctx.verify_mode = ssl.CERT_NONE

        with urllib.request.urlopen(url, context=ctx, timeout=30) as response:
            return response.read()
