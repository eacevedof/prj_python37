"""Servicio para crear grupos de palabras."""

from typing import final, Self

from ddd.shared.infrastructure.components.logger import Logger
from ddd.vocabulary.application.create_word_group.create_word_group_dto import CreateWordGroupDto
from ddd.vocabulary.application.create_word_group.create_word_group_result_dto import CreateWordGroupResultDto
from ddd.vocabulary.domain.entities import WordGroupEntity
from ddd.vocabulary.infrastructure.repositories import (
    WordGroupsReaderSqliteRepository,
    WordGroupsWriterSqliteRepository,
)


@final
class CreateWordGroupService:
    """Servicio para crear un nuevo grupo de palabras."""

    _instance: "CreateWordGroupService | None" = None

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._groups_reader = WordGroupsReaderSqliteRepository.get_instance()
        self._groups_writer = WordGroupsWriterSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def __call__(
        self,
        create_word_group_dto: CreateWordGroupDto
    ) -> CreateWordGroupResultDto:
        """
        Crea un nuevo grupo de palabras.

        Args:
            create_word_group_dto: DTO con datos del grupo.

        Returns:
            CreateWordGroupResultDto con el resultado.
        """
        # Validar DTO
        errors = create_word_group_dto.validate()
        if errors:
            return CreateWordGroupResultDto.error("; ".join(errors))

        # Verificar que no exista un grupo con el mismo título
        existing = await self._groups_reader.get_by_title(create_word_group_dto.title)
        if existing:
            return CreateWordGroupResultDto.error(
                f"A group with title '{create_word_group_dto.title}' already exists"
            )

        # Crear entidad
        word_group_entity = WordGroupEntity(
            id=0,
            title=create_word_group_dto.title,
            description=create_word_group_dto.description,
        )

        # Validar entidad
        errors = word_group_entity.validate()
        if errors:
            return CreateWordGroupResultDto.error("; ".join(errors))

        # Crear en BD
        result = await self._groups_writer.create(word_group_entity)

        return CreateWordGroupResultDto.ok(
            group_id=result["id"],
            title=result["title"],
            description=result.get("description", ""),
        )

