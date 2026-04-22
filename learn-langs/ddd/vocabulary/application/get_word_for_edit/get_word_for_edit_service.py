"""Servicio para obtener datos de palabra para editar."""

from typing import final, Self

from ddd.shared.infrastructure.components.logger import Logger
from ddd.vocabulary.application.get_tags.get_tags_result_dto import TagDto
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
        self._words_reader = WordsEsReaderSqliteRepository.get_instance()
        self._lang_reader = WordsLangReaderSqliteRepository.get_instance()
        self._tags_reader = TagsReaderSqliteRepository.get_instance()
        self._logger = Logger.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def __call__(self, dto: GetWordForEditDto) -> GetWordForEditResultDto:
        """
        Obtiene todos los datos necesarios para editar una palabra.

        Args:
            dto: DTO con el word_id.

        Returns:
            GetWordForEditResultDto con datos de la palabra, traducciones y tags.
        """
        try:
            # Cargar palabra
            word_data = await self._words_reader.get_by_id(dto.word_id)

            if not word_data:
                return GetWordForEditResultDto.not_found(dto.word_id)

            # Cargar traducciones
            translations_raw = await self._lang_reader.get_all_for_word(dto.word_id)
            translations = {
                t["lang_code"]: t["text"]
                for t in translations_raw
            }

            # Cargar tags de la palabra
            word_tags = await self._words_reader.get_tags_for_word(dto.word_id)
            selected_tags = [t["name"] for t in word_tags]

            # Cargar tags disponibles
            all_tags_raw = await self._tags_reader.get_all()
            available_tags = [TagDto.from_primitives(t) for t in all_tags_raw]

            return GetWordForEditResultDto.ok(
                word_id=dto.word_id,
                text=word_data.get("text", ""),
                word_type=word_data.get("word_type", "WORD"),
                notes=word_data.get("notes", "") or "",
                translations=translations,
                selected_tags=selected_tags,
                available_tags=available_tags,
            )

        except Exception as e:
            self._logger.write_error(
                "GetWordForEditService",
                f"Error obteniendo palabra para editar: {e}",
                {"word_id": dto.word_id},
            )
            return GetWordForEditResultDto.error(str(e))
