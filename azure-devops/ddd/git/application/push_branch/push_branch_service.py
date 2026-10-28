from typing import final, Self

from ddd.git.domain.enums.git_config_enum import GitConfig
from ddd.git.application.push_branch.push_branch_dto import PushBranchDto
from ddd.git.application.push_branch.push_branch_result_dto import PushBranchResultDto
from ddd.git.infrastructure.repositories.git_local_writer_cli_repository import (
    GitLocalWriterCliRepository,
)


@final
class PushBranchService:
    """Service that pushes a branch to a remote authenticating with an Azure PAT."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, push_branch_dto: PushBranchDto) -> PushBranchResultDto:
        git_local_writer_cli_repository = GitLocalWriterCliRepository.get_instance(
            push_branch_dto.repo_path
        )

        remote = push_branch_dto.remote or GitConfig.DEFAULT_REMOTE
        git_local_writer_cli_repository.push_with_pat(remote, push_branch_dto.branch)

        return PushBranchResultDto.from_primitives({
            "pushed": True,
            "remote": remote,
            "branch": push_branch_dto.branch,
        })
