from typing import final, Self

from src.modules.memory_mod.application.check_freshness.check_freshness_dto import CheckFreshnessDto
from src.modules.memory_mod.application.check_freshness.check_freshness_result_dto import CheckFreshnessResultDto
from src.modules.memory_mod.infrastructure.repositories import VectorDbReaderRepository


@final
class CheckFreshnessService:
    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: CheckFreshnessDto) -> CheckFreshnessResultDto:
        repository = VectorDbReaderRepository.get_instance()
        result = repository.check_freshness(project=dto.project)
        return CheckFreshnessResultDto.from_primitives(result)
