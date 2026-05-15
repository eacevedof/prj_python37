"""Servicio para generar imagenes de palabras con IA (OpenAI Extended Inference)."""

import base64
from typing import final, Self

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
    """Servicio para generar imagenes con OpenAI Extended Inference."""

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
        Genera una imagen para una palabra usando OpenAI Extended Inference.

        Args:
            generate_word_image_ai_dto: DTO con palabra en español y traducción.

        Returns:
            GenerateWordImageAiResultDto con el resultado.
        """
        try:
            if not generate_word_image_ai_dto.word_es or not generate_word_image_ai_dto.word_lang:
                return GenerateWordImageAiResultDto.error(
                    "Se requiere palabra en español y traducción"
                )

            # Generar imagen con Extended Inference (prompt oculto en el repositorio)
            ai_response = self._dalle_image_reader_repository.get_ai_image_by_word(
                word_es=generate_word_image_ai_dto.word_es,
                word_lang=generate_word_image_ai_dto.word_lang,
            )

            image_base64 = ai_response["image_base64"]
            prompt_used = ai_response["prompt_used"]

            # Decodificar imagen base64
            image_bytes = base64.b64decode(image_base64)

            # Guardar imagen en disco y BD
            word_image_entity = WordImageEntity(
                id=0,
                word_es_id=generate_word_image_ai_dto.word_id,
                source_type=ImageSourceEnum.AI_GENERATED,
                file_path="",
                mime_type="image/png",
                original_url="",
                caption=f"{generate_word_image_ai_dto.word_es} - {generate_word_image_ai_dto.word_lang}",
            )

            word_img_entity = await self._images_writer_repository.save_image_bytes(
                word_image_entity,
                image_bytes
            )

            return GenerateWordImageAiResultDto.ok(
                image_id=word_img_entity.id,
                word_id=generate_word_image_ai_dto.word_id,
                file_path=word_img_entity.file_path,
                dalle_url="",  # Ya no hay URL, la imagen viene en base64
                prompt_used=prompt_used,
            )

        except Exception as e:
            self._logger.log_error(
                "GenerateWordImageAiService",
                f"Error generando imagen con IA: {e}",
                {"word_id": generate_word_image_ai_dto.word_id, "word_es": generate_word_image_ai_dto.word_es},
            )
            return GenerateWordImageAiResultDto.error(str(e))
