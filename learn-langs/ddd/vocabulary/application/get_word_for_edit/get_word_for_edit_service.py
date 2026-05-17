"""Servicio para obtener datos de palabra para editar."""

from typing import final, Self

from ddd.shared.infrastructure.components.logger import Logger
from ddd.vocabulary.application.get_word_for_edit.get_word_for_edit_dto import (
    GetWordForEditDto,
)
from ddd.vocabulary.application.get_word_for_edit.get_word_for_edit_result_dto import (
    GetWordForEditResultDto,
)
from ddd.vocabulary.infrastructure.repositories import (
    WordsEsReaderSqliteRepository,
    WordsLangReaderSqliteRepository,
    TagsReaderSqliteRepository,
)


@final
class GetWordForEditService:
    """Servicio para obtener datos completos de una palabra para edicion."""

    _instance: "GetWordForEditService | None" = None

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._tags_reader_sqlite_repository = TagsReaderSqliteRepository.get_instance()
        self._words_es_reader_sqlite_repository = WordsEsReaderSqliteRepository.get_instance()
        self._words_lang_reader_sqlite_repository = WordsLangReaderSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def __call__(self, get_word_for_edit_dto: GetWordForEditDto) -> GetWordForEditResultDto:
        """
        Obtiene todos los datos necesarios para editar una palabra.

        Args:
            get_word_for_edit_dto: DTO con el word_id.

        Returns:
            GetWordForEditResultDto con datos de la palabra, traducciones y tags.
        """
        # Cargar palabra
        word_data = await self._words_es_reader_sqlite_repository.get_word_es_by_word_es_id(
            get_word_for_edit_dto.word_id
        )
        if not word_data:
            return GetWordForEditResultDto.not_found(get_word_for_edit_dto.word_id)

        # Cargar traducciones
        translations_raw = await self._words_lang_reader_sqlite_repository.get_all_for_word(get_word_for_edit_dto.word_id)
        translations = {
            t["lang_code"]: t["text"]
            for t in translations_raw
        }

        # Cargar tags de la palabra
        word_tags = await self._words_es_reader_sqlite_repository.get_word_es_tags_by_word_es_id(get_word_for_edit_dto.word_id)
        selected_tags = [word_tag["name"] for word_tag in word_tags]

        # Cargar tags disponibles
        all_tags_raw = await self._words_es_reader_sqlite_repository.get_filtered_words_es()

        return GetWordForEditResultDto.ok(
            word_id=get_word_for_edit_dto.word_id,
            text=word_data.get("text", ""),
            word_type=word_data.get("word_type", "WORD"),
            notes=word_data.get("notes", "") or "",
            translations=translations,
            selected_tags=selected_tags,
            available_tags=all_tags_raw,
        )
