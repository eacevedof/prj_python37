from typing import final, Self

from ddd.emt.application.get_stop_arrivals.get_stop_arrivals_dto import (
    GetStopArrivalsDto,
)
from ddd.emt.application.get_stop_arrivals.get_stop_arrivals_result_dto import (
    GetStopArrivalsResultDto,
)
from ddd.emt.infrastructure.repositories.emt_api_repository import EmtApiRepository


@final
class GetStopArrivalsService:
    """Service for getting real-time bus arrivals at a stop."""

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self, get_stop_arrivals_dto: GetStopArrivalsDto
    ) -> GetStopArrivalsResultDto:
        """Get bus arrivals for a specific stop.

        Args:
            get_stop_arrivals_dto: Input DTO with stop ID and optional line filter.

        Returns:
            GetStopArrivalsResultDto with arrival items.

        Raises:
            EmtException: If the request fails.
        """
        repository = EmtApiRepository.get_instance()

        response = await repository.get_stop_arrivals(
            stop_id=get_stop_arrivals_dto.stop_id,
            line_ids=get_stop_arrivals_dto.line_ids,
        )

        response["stop_id"] = get_stop_arrivals_dto.stop_id
        return GetStopArrivalsResultDto.from_primitives(response)
