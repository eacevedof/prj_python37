from typing import final, Self

from ddd.emt.application.get_stop_detail.get_stop_detail_dto import GetStopDetailDto
from ddd.emt.application.get_stop_detail.get_stop_detail_result_dto import (
    GetStopDetailResultDto,
)
from ddd.emt.infrastructure.repositories.emt_api_repository import EmtApiRepository


@final
class GetStopDetailService:
    """Service for getting bus stop details."""

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self, get_stop_detail_dto: GetStopDetailDto
    ) -> GetStopDetailResultDto:
        """Get detailed information about a specific stop.

        Args:
            get_stop_detail_dto: Input DTO with stop ID.

        Returns:
            GetStopDetailResultDto with stop details.

        Raises:
            EmtException: If the request fails.
        """
        repository = EmtApiRepository.get_instance()

        response = await repository.get_stop_detail(
            stop_id=get_stop_detail_dto.stop_id,
        )

        response["stop_id"] = get_stop_detail_dto.stop_id
        return GetStopDetailResultDto.from_primitives(response)
