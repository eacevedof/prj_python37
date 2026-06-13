from typing import final, Self

from ddd.ia_memory.application.get_memory_by_path.get_memory_by_path_dto import GetMemoryByPathDto
from ddd.ia_memory.application.get_memory_by_path.get_memory_by_path_result_dto import GetMemoryByPathResultDto
from ddd.ia_memory.infrastructure.repositories import VectorDbReaderRepository
from ddd.ia_memory.domain.exceptions import MemoryException


@final
class GetMemoryByPathService:
    """Retrieve memory chunks by file path (direct access, no semantic search)."""

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: GetMemoryByPathDto) -> GetMemoryByPathResultDto:
        """Get all chunks indexed from a specific file path."""

        repository = VectorDbReaderRepository.get_instance()

        # List all chunks for the project
        all_chunks_result = await repository.list_chunks(project=dto.project)

        # Filter by file path (exact match or contains)
        matching_chunks = [
            chunk for chunk in all_chunks_result["chunks"]
            if dto.file_path in chunk.get("paths", "")
        ]

        if not matching_chunks:
            MemoryException.not_found_custom(
                f"No memory found for path: {dto.file_path} in project {dto.project}"
            )

        return GetMemoryByPathResultDto.from_primitives({
            "project": dto.project,
            "file_path": dto.file_path,
            "total_chunks": len(matching_chunks),
            "chunks": matching_chunks,
        })
