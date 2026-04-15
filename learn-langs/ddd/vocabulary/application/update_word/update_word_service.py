"""Servicio para actualizar palabras."""

from typing import final, Self

from ddd.vocabulary.application.update_word.update_word_dto import UpdateWordDto
from ddd.vocabulary.application.update_word.update_word_result_dto import UpdateWordResultDto
from ddd.vocabulary.domain.entities import WordEsEntity, WordLangEntity
from ddd.vocabulary.domain.enums import WordTypeEnum
from ddd.vocabulary.domain.exceptions import VocabularyException
from ddd.vocabulary.infrastructure.repositories import (
    WordsEsReaderSqliteRepository,
    WordsEsWriterSqliteRepository,
    WordsLangReaderSqliteRepository,
    WordsLangWriterSqliteRepository,
    TagsReaderSqliteRepository,
)


@final
class UpdateWordService:
    """Servicio para actualizar palabras en espanol con traducciones y tags."""

    _update_word_dto: UpdateWordDto
    _words_es_reader: WordsEsReaderSqliteRepository
    _words_es_writer: WordsEsWriterSqliteRepository
    _words_lang_reader: WordsLangReaderSqliteRepository
    _words_lang_writer: WordsLangWriterSqliteRepository
    _tags_reader: TagsReaderSqliteRepository

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, update_word_dto: UpdateWordDto) -> UpdateWordResultDto:
        """
        Actualiza una palabra existente con sus traducciones y tags.

        Args:
            update_word_dto: Datos de la palabra a actualizar.

        Returns:
            UpdateWordResultDto con la palabra actualizada.

        Raises:
            VocabularyException: Si la validacion falla o la palabra no existe.
        """
        self._update_word_dto = update_word_dto
        self._words_es_reader = WordsEsReaderSqliteRepository.get_instance()
        self._words_es_writer = WordsEsWriterSqliteRepository.get_instance()
        self._words_lang_reader = WordsLangReaderSqliteRepository.get_instance()
        self._words_lang_writer = WordsLangWriterSqliteRepository.get_instance()
        self._tags_reader = TagsReaderSqliteRepository.get_instance()

        # Validar DTO
        errors = update_word_dto.validate()
        if errors:
            raise VocabularyException.word_update_failed(", ".join(errors))

        # Verificar que exista
        existing = await self._words_es_reader.get_by_id(update_word_dto.word_id)
        if not existing:
            raise VocabularyException.word_not_found(update_word_dto.word_id)

        # Verificar que el nuevo texto no exista en otra palabra
        if update_word_dto.text.lower() != existing["text"].lower():
            duplicate = await self._words_es_reader.get_by_text(update_word_dto.text)
            if duplicate and duplicate["id"] != update_word_dto.word_id:
                raise VocabularyException.word_already_exists(update_word_dto.text)

        # Actualizar entidad de palabra
        word_es_entity = WordEsEntity(
            id=update_word_dto.word_id,
            text=update_word_dto.text,
            word_type=WordTypeEnum(update_word_dto.word_type),
            image_path=existing.get("image_path", ""),
            notes=update_word_dto.notes,
        )

        await self._words_es_writer.update(word_es_entity)

        # Actualizar tags
        tags_updated = await self._update_tags(update_word_dto.word_id, update_word_dto.tags)

        # Actualizar traducciones
        translations_updated = await self._update_translations(
            update_word_dto.word_id,
            update_word_dto.translations,
        )

        return UpdateWordResultDto.from_primitives({
            "id": update_word_dto.word_id,
            "text": update_word_dto.text,
            "word_type": update_word_dto.word_type,
            "notes": update_word_dto.notes,
            "tags": tags_updated,
            "translations": translations_updated,
        })

    async def _update_tags(self, word_id: int, tag_names: list[str]) -> list[str]:
        """Actualiza los tags de la palabra."""
        tag_ids: list[int] = []
        updated_tags: list[str] = []

        for tag_name in tag_names:
            tag = await self._tags_reader.get_by_name(tag_name)
            if tag:
                tag_ids.append(tag["id"])
                updated_tags.append(tag_name)

        await self._words_es_writer.set_tags(word_id, tag_ids)
        return updated_tags

    async def _update_translations(
        self,
        word_id: int,
        translations: dict[str, str],
    ) -> dict[str, str]:
        """Actualiza las traducciones de la palabra."""
        updated_translations: dict[str, str] = {}

        for lang_code, text in translations.items():
            existing_translation = await self._words_lang_reader.get_by_word_and_lang(
                word_id, lang_code
            )

            if text and text.strip():
                if existing_translation:
                    # Actualizar traduccion existente
                    word_lang_entity = WordLangEntity(
                        id=existing_translation["id"],
                        word_es_id=word_id,
                        lang_code=lang_code,
                        text=text.strip(),
                        pronunciation=existing_translation.get("pronunciation", ""),
                        audio_path=existing_translation.get("audio_path", ""),
                        notes=existing_translation.get("notes", ""),
                    )
                    await self._words_lang_writer.update(word_lang_entity)
                else:
                    # Crear nueva traduccion
                    word_lang_entity = WordLangEntity(
                        id=0,
                        word_es_id=word_id,
                        lang_code=lang_code,
                        text=text.strip(),
                    )
                    await self._words_lang_writer.create(word_lang_entity)

                updated_translations[lang_code] = text.strip()
            elif existing_translation:
                # Eliminar traduccion si el texto esta vacio
                await self._words_lang_writer.delete_by_word_and_lang(word_id, lang_code)

        return updated_translations
