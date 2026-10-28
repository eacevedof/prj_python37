from typing import final, Self

from ddd.shared.infrastructure.components.slugger import Slugger
from ddd.git.domain.enums.git_config_enum import GitConfig
from ddd.git.domain.exceptions.git_exception import GitException
from ddd.git.application.create_integration_branch.create_integration_branch_dto import (
    CreateIntegrationBranchDto,
)
from ddd.git.application.create_integration_branch.create_integration_branch_result_dto import (
    CreateIntegrationBranchResultDto,
)
from ddd.git.infrastructure.repositories.git_local_reader_cli_repository import (
    GitLocalReaderCliRepository,
)
from ddd.git.infrastructure.repositories.git_local_writer_cli_repository import (
    GitLocalWriterCliRepository,
)


@final
class CreateIntegrationBranchService:
    """Service that creates an integration branch off a task's base branch."""

    _slugger: Slugger

    def __init__(self) -> None:
        self._slugger = Slugger.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self, create_integration_branch_dto: CreateIntegrationBranchDto
    ) -> CreateIntegrationBranchResultDto:
        git_local_reader_cli_repository = GitLocalReaderCliRepository.get_instance(
            create_integration_branch_dto.repo_path
        )
        git_local_writer_cli_repository = GitLocalWriterCliRepository.get_instance(
            create_integration_branch_dto.repo_path
        )

        if not git_local_reader_cli_repository.is_git_repo():
            raise GitException.not_a_git_repo(create_integration_branch_dto.repo_path)

        base_branch = (
            create_integration_branch_dto.base_branch
            or git_local_reader_cli_repository.get_base_branch()
        )
        if not base_branch:
            raise GitException.base_branch_not_found(
                create_integration_branch_dto.repo_path
            )

        slug = self._slugger.get_slugged_text(create_integration_branch_dto.title)
        new_branch = (
            f"{GitConfig.INTEGRATION_BRANCH_PREFIX}"
            f"{create_integration_branch_dto.task_id}-{slug}"
        )

        git_local_writer_cli_repository.create_integration_branch(base_branch, new_branch)

        return CreateIntegrationBranchResultDto.from_primitives({
            "branch": new_branch,
            "base_branch": base_branch,
            "task_id": create_integration_branch_dto.task_id,
        })
