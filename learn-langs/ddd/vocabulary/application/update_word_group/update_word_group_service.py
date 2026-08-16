"""Servicio para actualizar un grupo de palabras."""

from typing import final, Self

from ddd.vocabulary.application.update_word_group.update_word_group_dto import UpdateWordGroupDto
from ddd.vocabulary.application.update_word_group.update_word_group_result_dto import UpdateWordGroupResultDto
from ddd.vocabulary.domain.entities import WordGroupEntity
from ddd.vocabulary.domain.exceptions import VocabularyException
from ddd.vocabulary.infrastructure.repositories import (
    WordGroupsReaderSqliteRepository,
    WordGroupsWriterSqliteRepository,
)


@final
class UpdateWordGroupService:
    """Servicio para actualizar un grupo de palabras."""

    _word_groups_reader_sqlite_repository: WordGroupsReaderSqliteRepository
    _word_groups_writer_sqlite_repository: WordGroupsWriterSqliteRepository

    def __init__(self) -> None:
        self._word_groups_reader_sqlite_repository = WordGroupsReaderSqliteRepository.get_instance()
        self._word_groups_writer_sqlite_repository = WordGroupsWriterSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, update_word_group_dto: UpdateWordGroupDto) -> UpdateWordGroupResultDto:
        """
        Actualiza un grupo de palabras existente.

        Args:
            update_word_group_dto: Datos del grupo a actualizar.

        Returns:
            UpdateWordGroupResultDto con el grupo actualizado.

        Raises:
            VocabularyException: Si la validación falla o el grupo no existe.
        """
        # Validar DTO
        errors = update_word_group_dto.validate()
        if errors:
            VocabularyException.word_update_failed(", ".join(errors))

        # Verificar que el grupo existe
        existing = await self._word_groups_reader_sqlite_repository.get_word_group_by_group_id(update_word_group_dto.group_id)
        if not existing:
            VocabularyException.word_not_found(update_word_group_dto.group_id)

        # Crear entidad
        word_group_entity = WordGroupEntity(
            id=update_word_group_dto.group_id,
            title=update_word_group_dto.title,
            description=update_word_group_dto.description,
            source=update_word_group_dto.source,
        )

        # Actualizar
        result = await self._word_groups_writer_sqlite_repository.update(
            update_word_group_dto.group_id,
            word_group_entity,
        )

        return UpdateWordGroupResultDto.from_primitives(result)
