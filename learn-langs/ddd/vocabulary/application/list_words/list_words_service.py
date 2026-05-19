"""Servicio para listar palabras."""

from typing import final, Self

from ddd.vocabulary.application.list_words.list_words_dto import ListWordsDto
from ddd.vocabulary.application.list_words.list_words_result_dto import (
    ListWordsResultDto,
    WordItemDto,
)
from ddd.vocabulary.infrastructure.repositories import (
    WordsEsReaderSqliteRepository,
    WordsLangReaderSqliteRepository,
    ImagesReaderSqliteRepository,
)


@final
class ListWordsService:
    """Servicio para listar palabras con filtros."""

    _list_words_dto: ListWordsDto
    _words_es_reader_sqlite_repository: WordsEsReaderSqliteRepository
    _images_reader_sqlite_repository: ImagesReaderSqliteRepository
    _words_lang_reader_sqlite_repository: WordsLangReaderSqliteRepository

    def __init__(self) -> None:
        self._words_es_reader_sqlite_repository = WordsEsReaderSqliteRepository.get_instance()
        self._images_reader_sqlite_repository = ImagesReaderSqliteRepository.get_instance()
        self._words_lang_reader_sqlite_repository = WordsLangReaderSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, list_words_dto: ListWordsDto) -> ListWordsResultDto:
        """
        Lista palabras con filtros opcionales.

        Args:
            list_words_dto: Filtros de busqueda.

        Returns:
            ListWordsResultDto con las palabras encontradas.
        """
        self._list_words_dto = list_words_dto

        # Obtener palabras segun filtros
        if list_words_dto.search:
            words_raw = await self._words_es_reader_sqlite_repository.get_words_es_by_text_or_group(list_words_dto.search, limit=list_words_dto.limit)
        elif list_words_dto.tags:
            words_raw = await self._words_es_reader_sqlite_repository.get_words_es_by_tag_names(
                list_words_dto.tags, limit=list_words_dto.limit, offset=list_words_dto.offset
            )
        else:
            words_raw = await self._words_es_reader_sqlite_repository.get_filtered_words_es(
                word_type=list_words_dto.word_type,
                limit=list_words_dto.limit,
                offset=list_words_dto.offset,
            )

        # Enriquecer con conteo de imagenes y traducciones
        words: list[WordItemDto] = []
        for word in words_raw:
            word_id = word["id"]

            # Conteo de imagenes
            image_count = await self._images_reader_sqlite_repository.get_total_word_es_images_by_word_id(word_id)

            # Tags
            tags_data = await self._words_es_reader_sqlite_repository.get_word_es_tags_by_word_es_id(word_id)
            tags = [t["name"] for t in tags_data]

            # Traducciones
            translations_data = await self._words_lang_reader_sqlite_repository.get_all_for_word(word_id)
            translations = {t["lang_code"]: t["text"] for t in translations_data}

            word_item = WordItemDto.from_primitives({
                "id": word_id,
                "text": word["text"],
                "word_type": word.get("word_type", "WORD"),
                "notes": word.get("notes", ""),
                "created_at": word.get("created_at", ""),
                "updated_at": word.get("updated_at", ""),
                "image_count": image_count,
                "tags": tags,
                "translations": translations,
            })
            words.append(word_item)

        # Obtener total para paginacion
        total_count = await self._words_es_reader_sqlite_repository.get_total_words_es_by_word_type(word_type=list_words_dto.word_type)
        has_more = (list_words_dto.offset + len(words)) < total_count

        return ListWordsResultDto.from_primitives({
            "words": [w.to_dict() for w in words],
            "total_count": total_count,
            "has_more": has_more,
        })
