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

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: ListWordsDto) -> ListWordsResultDto:
        """
        Lista palabras con filtros opcionales.

        Args:
            dto: Filtros de busqueda.

        Returns:
            ListWordsResultDto con las palabras encontradas.
        """
        words_reader = WordsEsReaderSqliteRepository.get_instance()
        images_reader = ImagesReaderSqliteRepository.get_instance()
        lang_reader = WordsLangReaderSqliteRepository.get_instance()

        # Obtener palabras segun filtros
        if dto.search:
            words_raw = await words_reader.search(dto.search, limit=dto.limit)
        elif dto.tags:
            words_raw = await words_reader.get_by_tags(
                dto.tags, limit=dto.limit, offset=dto.offset
            )
        else:
            words_raw = await words_reader.get_all(
                word_type=dto.word_type,
                limit=dto.limit,
                offset=dto.offset,
            )

        # Enriquecer con conteo de imagenes y traducciones
        words: list[WordItemDto] = []
        for word in words_raw:
            word_id = word["id"]

            # Conteo de imagenes
            image_count = await images_reader.count_by_word_id(word_id)

            # Tags
            tags_data = await words_reader.get_tags_for_word(word_id)
            tags = [t["name"] for t in tags_data]

            # Traducciones
            translations_data = await lang_reader.get_all_for_word(word_id)
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
        total_count = await words_reader.count(word_type=dto.word_type)
        has_more = (dto.offset + len(words)) < total_count

        return ListWordsResultDto.from_primitives({
            "words": [w.to_dict() for w in words],
            "total_count": total_count,
            "has_more": has_more,
        })
