"""Servicio para obtener todos los grupos de palabras."""

from typing import final, Self

from ddd.vocabulary.application.get_word_groups.get_word_groups_result_dto import GetWordGroupsResultDto
from ddd.vocabulary.infrastructure.repositories import WordGroupsReaderSqliteRepository


@final
class GetWordGroupsService:
    """Servicio para obtener todos los grupos de palabras."""

    _word_groups_reader_sqlite_repository: WordGroupsReaderSqliteRepository

    def __init__(self) -> None:
        self._word_groups_reader_sqlite_repository = WordGroupsReaderSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self) -> GetWordGroupsResultDto:
        """
        Obtiene todos los grupos de palabras.

        Returns:
            GetWordGroupsResultDto con la lista de grupos.
        """
        groups = await self._word_groups_reader_sqlite_repository.get_all_word_groups()
        return GetWordGroupsResultDto.from_primitives({"groups": groups or []})
