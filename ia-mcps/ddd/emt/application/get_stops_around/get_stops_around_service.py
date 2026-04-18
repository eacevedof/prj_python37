from typing import final, Self

from ddd.emt.application.get_stops_around.get_stops_around_dto import (
    GetStopsAroundDto,
)
from ddd.emt.application.get_stops_around.get_stops_around_result_dto import (
    GetStopsAroundResultDto,
)
from ddd.emt.infrastructure.repositories.emt_api_repository import EmtApiRepository


@final
class GetStopsAroundService:
    """Service for getting bus stops around a geographic location."""

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self, get_stops_around_dto: GetStopsAroundDto
    ) -> GetStopsAroundResultDto:
        """Get bus stops around a geographic point.

        Args:
            get_stops_around_dto: Input DTO with coordinates and radius.

        Returns:
            GetStopsAroundResultDto with stop items.

        Raises:
            EmtException: If the request fails.
        """
        repository = EmtApiRepository.get_instance()

        response = await repository.get_stops_around(
            latitude=get_stops_around_dto.latitude,
            longitude=get_stops_around_dto.longitude,
            radius=get_stops_around_dto.radius,
        )

        response["latitude"] = get_stops_around_dto.latitude
        response["longitude"] = get_stops_around_dto.longitude
        response["radius"] = get_stops_around_dto.radius

        return GetStopsAroundResultDto.from_primitives(response)
