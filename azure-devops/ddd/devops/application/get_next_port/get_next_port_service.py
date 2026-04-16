from typing import final, Self

from ddd.shared.infrastructure.repositories import EnvironmentReaderRawRepository
from ddd.devops.application.get_next_port.get_next_port_dto import GetNextPortDto
from ddd.devops.application.get_next_port.get_next_port_result_dto import (
    GetNextPortResultDto,
)
from ddd.devops.infrastructure.repositories import LocalProjectRepository


@final
class GetNextPortService:
    """Service to get the next available port."""

    _env_reader: EnvironmentReaderRawRepository
    _local_project_repository: LocalProjectRepository

    def __init__(self) -> None:
        self._env_reader = EnvironmentReaderRawRepository.get_instance()
        self._local_project_repository = LocalProjectRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, get_next_port_dto: GetNextPortDto) -> GetNextPortResultDto:
        vhosts_file = self._env_reader.get_local_vhosts_file()
        port = await self._local_project_repository.get_next_available_port(vhosts_file)

        return GetNextPortResultDto.from_primitives(
            {
                "port": port,
            }
        )
