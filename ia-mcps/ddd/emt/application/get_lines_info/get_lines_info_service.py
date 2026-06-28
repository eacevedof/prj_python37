from datetime import datetime
from typing import final, Self

from ddd.emt.application.get_lines_info.get_lines_info_dto import GetLinesInfoDto
from ddd.emt.application.get_lines_info.get_lines_info_result_dto import (
    GetLinesInfoResultDto,
)
from ddd.emt.infrastructure.repositories.emt_api_repository import EmtApiRepository


@final
class GetLinesInfoService:
    """Service for getting bus lines information."""

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self, get_lines_info_dto: GetLinesInfoDto
    ) -> GetLinesInfoResultDto:
        """Get information about all bus lines.

        Args:
            get_lines_info_dto: Input DTO with optional date filter.

        Returns:
            GetLinesInfoResultDto with line items.

        Raises:
            EmtException: If the request fails.
        """
        repository = EmtApiRepository.get_instance()

        date = get_lines_info_dto.date or datetime.now().strftime("%Y%m%d")

        response = await repository.get_lines_info(
            line_id=get_lines_info_dto.line_id,
            date=date,
        )

        return GetLinesInfoResultDto.from_primitives(response)
