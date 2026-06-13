from typing import final, Self

from ddd.ia_memory.application.update_memory.update_memory_dto import UpdateMemoryDto
from ddd.ia_memory.application.update_memory.update_memory_result_dto import UpdateMemoryResultDto
from ddd.ia_memory.infrastructure.repositories import VectorDbWriterRepository


@final
class UpdateMemoryService:
    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: UpdateMemoryDto) -> UpdateMemoryResultDto:
        repository = VectorDbWriterRepository.get_instance()
        result = repository.update(
            chunk_id=dto.chunk_id,
            project=dto.project,
            content=dto.content,
            paths=dto.paths,
            metadata=dto.metadata,
        )
        return UpdateMemoryResultDto.from_primitives(result)
