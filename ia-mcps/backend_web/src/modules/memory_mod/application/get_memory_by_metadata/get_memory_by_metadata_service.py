from typing import final, Self

from src.modules.memory_mod.application.get_memory_by_metadata.get_memory_by_metadata_dto import GetMemoryByMetadataDto
from src.modules.memory_mod.application.get_memory_by_metadata.get_memory_by_metadata_result_dto import GetMemoryByMetadataResultDto
from src.modules.memory_mod.infrastructure.repositories import VectorDbReaderRepository
from src.modules.memory_mod.domain.exceptions import MemoryException


@final
class GetMemoryByMetadataService:
    """Retrieve memory chunks by metadata key-value pair (direct access, no search)."""

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: GetMemoryByMetadataDto) -> GetMemoryByMetadataResultDto:
        """Get all chunks matching metadata criteria."""

        repository = VectorDbReaderRepository.get_instance()

        # List all chunks for the project
        all_chunks_result = await repository.list_chunks(project=dto.project)

        # Filter by metadata key-value
        matching_chunks = [
            chunk for chunk in all_chunks_result["chunks"]
            if chunk.get("metadata", {}).get(dto.metadata_key) == dto.metadata_value
        ]

        if not matching_chunks:
            MemoryException.not_found_custom(
                f"No chunks with {dto.metadata_key}='{dto.metadata_value}' in project {dto.project}"
            )

        return GetMemoryByMetadataResultDto.from_primitives({
            "project": dto.project,
            "metadata_key": dto.metadata_key,
            "metadata_value": dto.metadata_value,
            "total_chunks": len(matching_chunks),
            "chunks": matching_chunks,
        })
