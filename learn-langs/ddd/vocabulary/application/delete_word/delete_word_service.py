"""Servicio para eliminar palabras."""

from typing import final, Self

from ddd.vocabulary.application.delete_word.delete_word_dto import DeleteWordDto
from ddd.vocabulary.application.delete_word.delete_word_result_dto import DeleteWordResultDto
from ddd.vocabulary.domain.entities import WordEsEntity
from ddd.vocabulary.domain.exceptions import VocabularyException
from ddd.vocabulary.infrastructure.repositories import (
    WordsEsReaderSqliteRepository,
    WordsEsWriterSqliteRepository,
    WordsLangReaderSqliteRepository,
    WordsLangWriterSqliteRepository,
    ImagesReaderSqliteRepository,
    ImagesWriterSqliteRepository,
)


@final
class DeleteWordService:
    """Servicio para eliminar palabras con sus dependencias."""

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: DeleteWordDto) -> DeleteWordResultDto:
        """
        Elimina una palabra y todas sus dependencias.

        Args:
            dto: Datos de la palabra a eliminar.

        Returns:
            DeleteWordResultDto con el resultado.

        Raises:
            VocabularyException: Si la validacion falla o la palabra no existe.
        """
        # Validar DTO
        errors = dto.validate()
        if errors:
            raise VocabularyException.word_delete_failed(", ".join(errors))

        # Verificar que exista
        words_reader = WordsEsReaderSqliteRepository.get_instance()
        word_data = await words_reader.get_by_id(dto.word_id)

        if not word_data:
            raise VocabularyException.word_not_found(dto.word_id)

        word_text = word_data["text"]

        # Contar y eliminar imagenes
        images_reader = ImagesReaderSqliteRepository.get_instance()
        images_count = await images_reader.count_by_word_id(dto.word_id)

        images_writer = ImagesWriterSqliteRepository.get_instance()
        await images_writer.delete_all_by_word(dto.word_id)

        # Contar y eliminar traducciones
        lang_reader = WordsLangReaderSqliteRepository.get_instance()
        translations = await lang_reader.get_all_for_word(dto.word_id)
        translations_count = len(translations)

        lang_writer = WordsLangWriterSqliteRepository.get_instance()
        for translation in translations:
            await lang_writer.delete_by_word_and_lang(dto.word_id, translation["lang_code"])

        # Eliminar tags asociados (la relacion, no los tags)
        words_writer = WordsEsWriterSqliteRepository.get_instance()
        await words_writer.set_tags(dto.word_id, [])  # Limpia todas las relaciones

        # Eliminar la palabra
        word_entity = WordEsEntity.from_primitives(word_data)
        await words_writer.delete(word_entity)

        return DeleteWordResultDto(
            word_id=dto.word_id,
            text=word_text,
            images_deleted=images_count,
            translations_deleted=translations_count,
        )
