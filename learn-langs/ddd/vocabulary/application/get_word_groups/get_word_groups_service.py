"""Servicio para obtener todos los grupos de palabras."""

from typing import final, Self

from ddd.shared.infrastructure.components.logger import Logger
from ddd.vocabulary.application.get_word_groups.get_word_groups_result_dto import GetWordGroupsResultDto
from ddd.vocabulary.infrastructure.repositories import WordGroupsReaderSqliteRepository


@final
class GetWordGroupsService:
    """Servicio para obtener todos los grupos de palabras."""

    _instance: "GetWordGroupsService | None" = None

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._groups_reader = WordGroupsReaderSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def __call__(self) -> GetWordGroupsResultDto:
        """
        Obtiene todos los grupos de palabras.

        Returns:
            GetWordGroupsResultDto con la lista de grupos.
        """
        try:
            groups = await self._groups_reader.get_all()
            return GetWordGroupsResultDto.ok(groups)

        except Exception as e:
            self._logger.log_error(
                "GetWordGroupsService",
                f"Error getting word groups: {e}",
                {},
            )
            return GetWordGroupsResultDto.error(str(e))
