"""Servicio para agregar imagen generada con IA a palabra."""

from typing import final, Self

from ddd.shared.infrastructure.components.logger import Logger
from ddd.vocabulary.application.add_word_ia_image.add_word_ia_image_dto import (
    AddWordIaImageDto,
)
from ddd.vocabulary.application.add_word_ia_image.add_word_ia_image_result_dto import (
    AddWordIaImageResultDto,
)
from ddd.vocabulary.application.generate_word_image_ai import (
    GenerateWordImageAiDto,
    GenerateWordImageAiService,
)
from ddd.vocabulary.infrastructure.repositories import (
    WordsEsReaderSqliteRepository,
    WordsLangReaderSqliteRepository,
    TagsReaderSqliteRepository,
)


@final
class AddWordIaImageService:
    """Servicio para agregar imagen generada con IA a palabra."""

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._words_es_reader = WordsEsReaderSqliteRepository.get_instance()
        self._words_lang_reader = WordsLangReaderSqliteRepository.get_instance()
        self._tags_reader = TagsReaderSqliteRepository.get_instance()
        self._generate_image_service = GenerateWordImageAiService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: AddWordIaImageDto) -> AddWordIaImageResultDto:
        """
        Genera y agrega una imagen con IA a una palabra.

        Args:
            dto: DTO con word_id y lang_code.

        Returns:
            AddWordIaImageResultDto con el resultado.
        """
        try:
            # Obtener palabra en español
            word_es_data = await self._words_es_reader.get_by_id(dto.word_id)
            if not word_es_data:
                return AddWordIaImageResultDto.error(
                    f"Palabra con ID {dto.word_id} no encontrada"
                )

            word_es_text = word_es_data.get("text", "")
            word_es_notes = word_es_data.get("notes", "")

            # Obtener tags de la palabra (en español)
            tags_data = await self._tags_reader.get_for_word(dto.word_id)
            tag_names = [tag.get("name", "") for tag in tags_data] if tags_data else []

            # Construir contexto con tags y notas (todo en español)
            context_parts = []
            if tag_names:
                context_parts.append(f"Tags: {', '.join(tag_names)}")
            if word_es_notes:
                context_parts.append(f"Notas: {word_es_notes}")

            context = ". ".join(context_parts) if context_parts else None

            # Generar imagen con IA usando solo texto en español + contexto
            generate_dto = GenerateWordImageAiDto.from_primitives({
                "word_id": dto.word_id,
                "word_es": word_es_text,
                "word_lang": word_es_text,  # Usar el texto en español también aquí
                "lang_code": dto.lang_code,
                "context": context,
            })

            result = await self._generate_image_service(generate_dto)

            if not result.success:
                return AddWordIaImageResultDto.error(
                    result.error_message or "Error generando imagen con IA"
                )

            return AddWordIaImageResultDto.ok(
                image_id=result.image_id,
                word_id=result.word_id,
                file_path=result.file_path,
                dalle_url=result.dalle_url,
                prompt_used=result.prompt_used,
            )

        except Exception as e:
            self._logger.log_error(
                "AddWordIaImageService",
                f"Error agregando imagen con IA: {e}",
                {"word_id": dto.word_id, "lang_code": dto.lang_code},
            )
            return AddWordIaImageResultDto.error(str(e))
