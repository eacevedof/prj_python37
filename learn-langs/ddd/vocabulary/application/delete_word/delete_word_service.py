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

    _delete_word_dto: DeleteWordDto
    _words_es_reader_sqlite_repository: WordsEsReaderSqliteRepository
    _words_es_writer_sqlite_repository: WordsEsWriterSqliteRepository
    _words_lang_reader_sqlite_repository: WordsLangReaderSqliteRepository
    _words_lang_writer_sqlite_repository: WordsLangWriterSqliteRepository
    _images_reader_sqlite_repository: ImagesReaderSqliteRepository
    _images_writer_sqlite_repository: ImagesWriterSqliteRepository

    def __init__(self) -> None:
        self._words_es_reader_sqlite_repository = WordsEsReaderSqliteRepository.get_instance()
        self._words_es_writer_sqlite_repository = WordsEsWriterSqliteRepository.get_instance()
        self._words_lang_reader_sqlite_repository = WordsLangReaderSqliteRepository.get_instance()
        self._words_lang_writer_sqlite_repository = WordsLangWriterSqliteRepository.get_instance()
        self._images_reader_sqlite_repository = ImagesReaderSqliteRepository.get_instance()
        self._images_writer_sqlite_repository = ImagesWriterSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, delete_word_dto: DeleteWordDto) -> DeleteWordResultDto:
        """
        Elimina una palabra y todas sus dependencias.

        Args:
            delete_word_dto: Datos de la palabra a eliminar.

        Returns:
            DeleteWordResultDto con el resultado.

        Raises:
            VocabularyException: Si la validacion falla o la palabra no existe.
        """
        self._delete_word_dto = delete_word_dto

        # Validar DTO
        errors = delete_word_dto.validate()
        if errors:
            VocabularyException.bad_request_custom("wrong input: "+", ".join(errors))

        # Verificar que exista
        word_es_entity = await self._words_es_reader_sqlite_repository.get_word_es_by_word_es_id(
            delete_word_dto.word_id
        )
        if not word_es_entity:
            VocabularyException.custom_not_found(f"word not found by id {delete_word_dto.word_id}")

        # Contar y eliminar imagenes
        images_count = await self._images_reader_sqlite_repository.get_total_word_es_images_by_word_id(
            delete_word_dto.word_id
        )
        await self._images_writer_sqlite_repository.delete_all_by_word(delete_word_dto.word_id)

        # Contar y eliminar traducciones
        word_translations = await self._words_lang_reader_sqlite_repository.get_all_for_word(delete_word_dto.word_id)
        translations_count = len(word_translations)

        for word_translation in word_translations:
            await self._words_lang_writer_sqlite_repository.delete_by_word_and_lang_code(
                delete_word_dto.word_id,
                word_translation["lang_code"]
            )

        # Eliminar tags asociados (la relacion, no los tags)
        await self._words_es_writer_sqlite_repository.set_tags(delete_word_dto.word_id, [])

        # Eliminar la palabra
        word_es_ent = WordEsEntity.from_primitives(word_es_entity)
        await self._words_es_writer_sqlite_repository.delete(word_es_ent)

        word_text = word_es_entity["text"]
        return DeleteWordResultDto.from_primitives({
            "word_id": delete_word_dto.word_id,
            "text": word_text,
            "images_deleted": images_count,
            "translations_deleted": translations_count,
        })
