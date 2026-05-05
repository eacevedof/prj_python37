from typing import Any, final, Self

from ddd.ia_memory.application.list_memories.list_memories_dto import ListMemoriesDto
from ddd.ia_memory.infrastructure.repositories import VectorDbRepository


@final
class ListMemoriesService:
    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: ListMemoriesDto) -> dict[str, Any]:
        repository = VectorDbRepository.get_instance()
        return repository.list_chunks(
            project=dto.project,
            memory_type=dto.memory_type,
            stale_only=dto.stale_only,
        )
