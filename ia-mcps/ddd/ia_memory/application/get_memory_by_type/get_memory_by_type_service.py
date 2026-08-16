from typing import final, Self

from ddd.ia_memory.application.get_memory_by_type.get_memory_by_type_dto import GetMemoryByTypeDto
from ddd.ia_memory.application.get_memory_by_type.get_memory_by_type_result_dto import GetMemoryByTypeResultDto
from ddd.ia_memory.infrastructure.repositories import VectorDbReaderRepository
from ddd.ia_memory.domain.exceptions import MemoryException


@final
class GetMemoryByTypeService:
    """Retrieve all memory chunks of a specific type (direct access, no search)."""

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: GetMemoryByTypeDto) -> GetMemoryByTypeResultDto:
        """Get all chunks of a specific memory type."""

        repository = VectorDbReaderRepository.get_instance()

        # List chunks filtered by type
        result = await repository.list_chunks(
            project=dto.project,
            memory_type=dto.memory_type
        )

        if not result["chunks"]:
            MemoryException.not_found_custom(
                f"No memory of type '{dto.memory_type.value}' found in project {dto.project}"
            )

        return GetMemoryByTypeResultDto.from_primitives({
            "project": dto.project,
            "memory_type": dto.memory_type.value,
            "total_chunks": result["total_chunks"],
            "chunks": result["chunks"],
        })
