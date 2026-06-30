from typing import final, Self

from ddd.shared.infrastructure.repositories import EnvironmentReaderEnvRepository
from ddd.devops.application.get_next_port.get_next_port_dto import GetNextPortDto
from ddd.devops.application.get_next_port.get_next_port_result_dto import (
    GetNextPortResultDto,
)
from ddd.devops.infrastructure.repositories import LocalProjectReaderFileRepository


@final
class GetNextPortService:
    """Service to get the next available port."""

    _environment_reader_env_repository: EnvironmentReaderEnvRepository
    _local_project_reader_file_repository: LocalProjectReaderFileRepository

    def __init__(self) -> None:
        self._environment_reader_env_repository = (
            EnvironmentReaderEnvRepository.get_instance()
        )
        self._local_project_reader_file_repository = (
            LocalProjectReaderFileRepository.get_instance()
        )

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, get_next_port_dto: GetNextPortDto) -> GetNextPortResultDto:
        vhosts_file = self._environment_reader_env_repository.get_local_vhosts_file()
        port = await self._local_project_reader_file_repository.get_next_available_port(
            vhosts_file
        )

        return GetNextPortResultDto.from_primitives(
            {
                "port": port,
            }
        )
