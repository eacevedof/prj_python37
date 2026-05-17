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
    _instance: "AddWordIaImageService | None" = None

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._words_es_reader_sqlite_repository = WordsEsReaderSqliteRepository.get_instance()
        self._words_lang_reader_sqlite_repository = WordsLangReaderSqliteRepository.get_instance()
        self._tags_reader_sqlite_repository = TagsReaderSqliteRepository.get_instance()

        self._generate_word_image_ai_service = GenerateWordImageAiService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def __call__(
        self,
        add_word_ia_dto: AddWordIaImageDto
    ) -> AddWordIaImageResultDto:
        """
        Genera y agrega una imagen con IA a una palabra.

        Args:
            add_word_ia_dto: DTO con word_id y lang_code.

        Returns:
            AddWordIaImageResultDto con el resultado.
        """
        # Obtener palabra en español
        word_es_data = await self._words_es_reader_sqlite_repository.get_word_es_by_word_es_id(add_word_ia_dto.word_id)
        if not word_es_data:
            return AddWordIaImageResultDto.error(
                f"Palabra con ID {add_word_ia_dto.word_id} no encontrada"
            )

        word_es_text = word_es_data.get("text", "")
        word_es_notes = word_es_data.get("notes", "")

        # Obtener tags de la palabra (en español)
        tags_data = await self._tags_reader_sqlite_repository.get_tags_by_word_es_id(add_word_ia_dto.word_id)
        tag_names = [tag.get("name", "") for tag in tags_data] if tags_data else []

        # Construir contexto con tags y notas (todo en español)
        context_parts = []
        if tag_names:
            context_parts.append(f"Tags: {', '.join(tag_names)}")
        if word_es_notes:
            context_parts.append(f"Notas: {word_es_notes}")

        context = ". ".join(context_parts) if context_parts else None

        # Generar imagen con IA usando solo texto en español + contexto
        generate_ai_result = await self._generate_word_image_ai_service(
            GenerateWordImageAiDto.from_primitives({
                "word_id": add_word_ia_dto.word_id,
                "word_es": word_es_text,
                "word_lang": word_es_text,  # Usar el texto en español también aquí
                "lang_code": add_word_ia_dto.lang_code,
                "context": context,
            })
        )

        if not generate_ai_result.success:
            return AddWordIaImageResultDto.error(
                generate_ai_result.error_message or "Error generando imagen con IA"
            )

        return AddWordIaImageResultDto.ok(
            image_id=generate_ai_result.image_id,
            word_id=generate_ai_result.word_id,
            file_path=generate_ai_result.file_path,
            dalle_url=generate_ai_result.dalle_url,
            prompt_used=generate_ai_result.prompt_used,
        )
