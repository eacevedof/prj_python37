from typing import final, Self

from src.modules.memory_mod.application.delete_memory.delete_memory_dto import DeleteMemoryDto
from src.modules.memory_mod.application.delete_memory.delete_memory_result_dto import DeleteMemoryResultDto
from src.modules.memory_mod.infrastructure.repositories import VectorDbWriterRepository


@final
class DeleteMemoryService:
    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: DeleteMemoryDto) -> DeleteMemoryResultDto:
        repository = VectorDbWriterRepository.get_instance()
        result = repository.delete(chunk_id=dto.chunk_id, project=dto.project)
        return DeleteMemoryResultDto.from_primitives(result)
