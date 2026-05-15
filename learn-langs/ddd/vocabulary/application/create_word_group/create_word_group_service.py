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

    async def __call__(self, dto: CreateWordGroupDto) -> CreateWordGroupResultDto:
        """
        Crea un nuevo grupo de palabras.

        Args:
            dto: DTO con datos del grupo.

        Returns:
            CreateWordGroupResultDto con el resultado.
        """
        try:
            # Validar DTO
            errors = dto.validate()
            if errors:
                return CreateWordGroupResultDto.error("; ".join(errors))

            # Verificar que no exista un grupo con el mismo título
            existing = await self._groups_reader.get_by_title(dto.title)
            if existing:
                return CreateWordGroupResultDto.error(
                    f"A group with title '{dto.title}' already exists"
                )

            # Crear entidad
            entity = WordGroupEntity(
                id=0,
                title=dto.title,
                description=dto.description,
            )

            # Validar entidad
            errors = entity.validate()
            if errors:
                return CreateWordGroupResultDto.error("; ".join(errors))

            # Crear en BD
            result = await self._groups_writer.create(entity)

            return CreateWordGroupResultDto.ok(
                group_id=result["id"],
                title=result["title"],
                description=result.get("description", ""),
            )

        except Exception as e:
            self._logger.log_error(
                "CreateWordGroupService",
                f"Error creating word group: {e}",
                {"title": dto.title},
            )
            return CreateWordGroupResultDto.error(str(e))
