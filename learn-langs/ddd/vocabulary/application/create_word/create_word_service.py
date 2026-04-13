from typing import final, Self

from ddd.vocabulary.application.create_word.create_word_dto import CreateWordDto
from ddd.vocabulary.application.create_word.create_word_result_dto import CreateWordResultDto
from ddd.vocabulary.domain.exceptions import VocabularyException
from ddd.vocabulary.infrastructure.repositories import (
    WordsEsReaderSqliteRepository,
    WordsEsWriterSqliteRepository,
    WordsLangWriterSqliteRepository,
    TagsReaderSqliteRepository,
)


@final
class CreateWordService:
    """Servicio para crear palabras en español con traducciones y tags."""

    _create_word_dto: CreateWordDto
    _words_es_reader: WordsEsReaderSqliteRepository
    _words_es_writer: WordsEsWriterSqliteRepository
    _words_lang_writer: WordsLangWriterSqliteRepository
    _tags_reader: TagsReaderSqliteRepository

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, create_word_dto: CreateWordDto) -> CreateWordResultDto:
        """
        Crea una nueva palabra con sus traducciones y tags.

        Args:
            create_word_dto: Datos de la palabra a crear.

        Returns:
            CreateWordResultDto con la palabra creada.

        Raises:
            VocabularyException: Si la validacion falla o la palabra ya existe.
        """
        self._create_word_dto = create_word_dto
        self._words_es_reader = WordsEsReaderSqliteRepository.get_instance()
        self._words_es_writer = WordsEsWriterSqliteRepository.get_instance()
        self._words_lang_writer = WordsLangWriterSqliteRepository.get_instance()
        self._tags_reader = TagsReaderSqliteRepository.get_instance()

        # Validar DTO
        errors = create_word_dto.validate()
        if errors:
            raise VocabularyException.word_creation_failed(", ".join(errors))

        # Verificar que no exista
        existing = await self._words_es_reader.get_by_text(create_word_dto.text)
        if existing:
            raise VocabularyException.word_already_exists(create_word_dto.text)

        # Crear palabra
        word_data = await self._words_es_writer.create(
            text=create_word_dto.text,
            word_type=create_word_dto.word_type,
            image_path=create_word_dto.image_path,
            notes=create_word_dto.notes,
        )
        word_id = word_data["id"]

        # Anadir tags
        tags_added = await self._add_tags(word_id, create_word_dto.tags)

        # Anadir traducciones
        translations_added = await self._add_translations(word_id, create_word_dto.translations)

        return CreateWordResultDto.from_primitives({
            **word_data,
            "tags": tags_added,
            "translations": translations_added,
        })

    async def _add_tags(self, word_id: int, tag_names: list[str]) -> list[str]:
        """Añade tags a la palabra, creándolos si no existen."""
        if not tag_names:
            return []

        added_tags: list[str] = []

        for tag_name in tag_names:
            tag = await self._tags_reader.get_by_name(tag_name)
            if tag:
                await self._words_es_writer.add_tag(word_id, tag["id"])
                added_tags.append(tag_name)

        return added_tags

    async def _add_translations(
        self,
        word_id: int,
        translations: dict[str, str],
    ) -> dict[str, str]:
        """Añade traducciones a la palabra."""
        if not translations:
            return {}

        added_translations: dict[str, str] = {}

        for lang_code, text in translations.items():
            if text and text.strip():
                await self._words_lang_writer.create(
                    word_es_id=word_id,
                    lang_code=lang_code,
                    text=text.strip(),
                )
                added_translations[lang_code] = text.strip()

        return added_translations
