from typing import final, Self

from ddd.ia_memory.application.search_memory.search_memory_dto import SearchMemoryDto
from ddd.ia_memory.application.search_memory.search_memory_result_dto import SearchMemoryResultDto
from ddd.ia_memory.infrastructure.repositories import VectorDbReaderRepository


@final
class SearchMemoryService:
    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: SearchMemoryDto) -> SearchMemoryResultDto:
        repository = VectorDbReaderRepository.get_instance()
        result = repository.search(
            project=dto.project,
            query=dto.query,
            limit=dto.limit,
            memory_type=dto.memory_type,
        )
        return SearchMemoryResultDto.from_primitives(result)
