from typing import Any, final, Self

from ddd.ia_memory.application.delete_memory.delete_memory_dto import DeleteMemoryDto
from ddd.ia_memory.infrastructure.repositories import VectorDbRepository


@final
class DeleteMemoryService:
    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: DeleteMemoryDto) -> dict[str, Any]:
        repository = VectorDbRepository.get_instance()
        return repository.delete(chunk_id=dto.chunk_id, project=dto.project)
