from typing import Any, final, Self

from ddd.ia_memory.application.check_freshness.check_freshness_dto import CheckFreshnessDto
from ddd.ia_memory.infrastructure.repositories import VectorDbRepository


@final
class CheckFreshnessService:
    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: CheckFreshnessDto) -> dict[str, Any]:
        repository = VectorDbRepository.get_instance()
        return repository.check_freshness(project=dto.project)
