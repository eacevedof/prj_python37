from typing import Any, final, Self

from ddd.ia_memory.application.search_memory.search_memory_dto import SearchMemoryDto
from ddd.ia_memory.infrastructure.repositories import VectorDbRepository


@final
class SearchMemoryService:
    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: SearchMemoryDto) -> dict[str, Any]:
        repository = VectorDbRepository.get_instance()
        return repository.search(
            project=dto.project,
            query=dto.query,
            limit=dto.limit,
            memory_type=dto.memory_type,
        )
