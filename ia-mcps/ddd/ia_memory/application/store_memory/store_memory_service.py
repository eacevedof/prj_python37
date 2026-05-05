from typing import Any, final, Self

from ddd.ia_memory.application.store_memory.store_memory_dto import StoreMemoryDto
from ddd.ia_memory.infrastructure.repositories import VectorDbRepository


@final
class StoreMemoryService:
    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: StoreMemoryDto) -> dict[str, Any]:
        repository = VectorDbRepository.get_instance()
        return repository.store(
            project=dto.project,
            memory_type=dto.memory_type,
            content=dto.content,
            paths=dto.paths,
            metadata=dto.metadata,
        )
