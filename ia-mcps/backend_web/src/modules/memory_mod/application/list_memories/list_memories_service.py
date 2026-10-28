from typing import final, Self

from src.modules.memory_mod.application.list_memories.list_memories_dto import ListMemoriesDto
from src.modules.memory_mod.application.list_memories.list_memories_result_dto import ListMemoriesResultDto
from src.modules.memory_mod.infrastructure.repositories import VectorDbReaderRepository


@final
class ListMemoriesService:
    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: ListMemoriesDto) -> ListMemoriesResultDto:
        repository = VectorDbReaderRepository.get_instance()
        result = repository.list_chunks(
            project=dto.project,
            memory_type=dto.memory_type,
            stale_only=dto.stale_only,
        )
        return ListMemoriesResultDto.from_primitives(result)
