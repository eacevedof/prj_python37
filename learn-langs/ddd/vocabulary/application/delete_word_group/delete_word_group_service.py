"""Servicio para eliminar un grupo de palabras."""

from typing import final, Self

from ddd.vocabulary.application.delete_word_group.delete_word_group_dto import DeleteWordGroupDto
from ddd.vocabulary.application.delete_word_group.delete_word_group_result_dto import DeleteWordGroupResultDto
from ddd.vocabulary.domain.exceptions import VocabularyException
from ddd.vocabulary.infrastructure.repositories import (
    WordGroupsReaderSqliteRepository,
    WordGroupsWriterSqliteRepository,
)


@final
class DeleteWordGroupService:
    """Servicio para eliminar un grupo de palabras."""

    _word_groups_reader_sqlite_repository: WordGroupsReaderSqliteRepository
    _word_groups_writer_sqlite_repository: WordGroupsWriterSqliteRepository

    def __init__(self) -> None:
        self._word_groups_reader_sqlite_repository = WordGroupsReaderSqliteRepository.get_instance()
        self._word_groups_writer_sqlite_repository = WordGroupsWriterSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, delete_word_group_dto: DeleteWordGroupDto) -> DeleteWordGroupResultDto:
        """
        Elimina un grupo de palabras.

        Args:
            delete_word_group_dto: Datos del grupo a eliminar.

        Returns:
            DeleteWordGroupResultDto con resultado.

        Raises:
            VocabularyException: Si la validación falla o el grupo no existe.
        """
        # Validar DTO
        errors = delete_word_group_dto.validate()
        if errors:
            VocabularyException.word_delete_failed(", ".join(errors))

        # Verificar que el grupo existe
        existing = await self._word_groups_reader_sqlite_repository.get_by_id(delete_word_group_dto.group_id)
        if not existing:
            VocabularyException.word_not_found(delete_word_group_dto.group_id)

        # No permitir eliminar el grupo "generic"
        if existing.get("title", "").lower() == "generic":
            VocabularyException.word_delete_failed("No se puede eliminar el grupo 'generic'")

        title = existing.get("title", "")

        # Eliminar
        await self._word_groups_writer_sqlite_repository.delete(delete_word_group_dto.group_id)

        return DeleteWordGroupResultDto.from_primitives({
            "group_id": delete_word_group_dto.group_id,
            "title": title,
        })
