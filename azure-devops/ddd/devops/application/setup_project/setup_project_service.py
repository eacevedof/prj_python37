from typing import final, Self

from ddd.shared.infrastructure.components.logger import Logger
from ddd.shared.infrastructure.repositories import EnvironmentReaderRawRepository
from ddd.devops.application.setup_project.setup_project_dto import SetupProjectDto
from ddd.devops.application.setup_project.setup_project_result_dto import (
    SetupProjectResultDto,
)
from ddd.devops.infrastructure.repositories import LocalProjectRepository


@final
class SetupProjectService:
    """Service to setup a new local project with all configurations."""

    _logger: Logger
    _env_reader_raw_repository: EnvironmentReaderRawRepository
    _local_project_repository: LocalProjectRepository

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._env_reader_raw_repository = EnvironmentReaderRawRepository.get_instance()
        self._local_project_repository = LocalProjectRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self, setup_project_dto: SetupProjectDto
    ) -> SetupProjectResultDto:
        steps_completed: list[str] = []

        port = await self._resolve_port(setup_project_dto.port)
        app_folder = f"app-{setup_project_dto.project_name}"
        server_name = f"local-{port}"

        self._log_start(setup_project_dto.project_name, port, setup_project_dto.db_name)

        app_path = await self.__git_clone_repository(setup_project_dto, steps_completed)
        await self.__add_apache_virtualhost(
            setup_project_dto.project_name, port, steps_completed
        )
        await self.__create_mysql_database(setup_project_dto.db_name, steps_completed)
        await self.__add_into_file_hosts_entry(
            port, setup_project_dto.project_name, steps_completed
        )
        env_path = await self.__create_dot_env_file(
            setup_project_dto, port, steps_completed
        )
        await self.__restart_apache_in_docker(steps_completed)

        return self._get_built_result(
            setup_project_dto,
            app_folder,
            app_path,
            port,
            server_name,
            env_path,
            steps_completed,
        )

    def _get_built_result(
        self,
        setup_project_dto: SetupProjectDto,
        app_folder: str,
        app_path: str,
        port: int,
        server_name: str,
        env_path: str,
        steps_completed: list[str],
    ) -> SetupProjectResultDto:
        return SetupProjectResultDto.from_primitives(
            {
                "project_name": setup_project_dto.project_name,
                "app_folder": app_folder,
                "app_path": app_path,
                "port": port,
                "server_name": server_name,
                "db_name": setup_project_dto.db_name,
                "url": f"http://{server_name}:{port}/",
                "env_path": env_path,
                "steps_completed": steps_completed,
            }
        )

    async def _resolve_port(self, port: int | None) -> int:
        if port:
            return port
        vhosts_file = self._env_reader_raw_repository.get_local_vhosts_file()
        return await self._local_project_repository.get_next_available_port(vhosts_file)

    def _log_start(self, project_name: str, port: int, db_name: str) -> None:
        self._logger.write_info(
            module="SetupProjectService",
            message=f"Starting setup for project: {project_name}",
            context={"port": port, "db_name": db_name},
        )

    async def __git_clone_repository(
        self,
        setup_project_dto: SetupProjectDto,
        steps_completed: list[str],
    ) -> str:
        www_path = self._env_reader_raw_repository.get_local_www_path()
        app_path = await self._local_project_repository.clone_repository(
            www_path, setup_project_dto.repo_url, setup_project_dto.project_name
        )
        steps_completed.append("repository_cloned")
        return app_path

    async def __add_apache_virtualhost(
        self,
        project_name: str,
        port: int,
        steps_completed: list[str],
    ) -> None:
        vhosts_file = self._env_reader_raw_repository.get_local_vhosts_file()
        await self._local_project_repository.add_virtualhost(
            vhosts_file, project_name, port
        )
        steps_completed.append("virtualhost_added")

    async def __create_mysql_database(
        self,
        db_name: str,
        steps_completed: list[str],
    ) -> None:
        await self._local_project_repository.create_database(db_name)
        steps_completed.append("database_created")

    async def __add_into_file_hosts_entry(
        self,
        port: int,
        project_name: str,
        steps_completed: list[str],
    ) -> None:
        hosts_file = self._env_reader_raw_repository.get_local_hosts_file()
        try:
            await self._local_project_repository.add_hosts_entry(
                hosts_file, port, project_name
            )
            steps_completed.append("hosts_entry_added")
        except PermissionError:
            self._logger.write_error(
                module="SetupProjectService",
                message="Could not add hosts entry (requires admin)",
            )
            steps_completed.append("hosts_entry_skipped_no_admin")

    async def __create_dot_env_file(
        self,
        setup_project_dto: SetupProjectDto,
        port: int,
        steps_completed: list[str],
    ) -> str:
        www_path = self._env_reader_raw_repository.get_local_www_path()
        base_env_file = self._env_reader_raw_repository.get_local_base_env_file()
        env_path = await self._local_project_repository.create_env_file(
            www_path,
            base_env_file,
            setup_project_dto.project_name,
            port,
            setup_project_dto.db_name,
        )
        steps_completed.append("env_file_created")
        return env_path

    async def __restart_apache_in_docker(self, steps_completed: list[str]) -> None:
        docker_lamp_path = self._env_reader_raw_repository.get_local_docker_lamp_path()
        await self._local_project_repository.restart_apache(docker_lamp_path)
        steps_completed.append("apache_restarted")
