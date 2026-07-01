from typing import final, Self

from ddd.git.domain.enums.git_config_enum import GitConfig
from ddd.git.domain.exceptions.git_exception import GitException
from ddd.git.application.squash_task_commits.squash_task_commits_dto import (
    SquashTaskCommitsDto,
)
from ddd.git.application.squash_task_commits.squash_task_commits_result_dto import (
    SquashTaskCommitsResultDto,
)
from ddd.git.infrastructure.repositories.git_local_reader_cli_repository import (
    GitLocalReaderCliRepository,
)
from ddd.git.infrastructure.repositories.git_local_writer_cli_repository import (
    GitLocalWriterCliRepository,
)


@final
class SquashTaskCommitsService:
    """Service that squashes a task's commits into one team-formatted commit."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self, squash_task_commits_dto: SquashTaskCommitsDto
    ) -> SquashTaskCommitsResultDto:
        git_local_reader_cli_repository = GitLocalReaderCliRepository.get_instance(
            squash_task_commits_dto.repo_path
        )
        git_local_writer_cli_repository = GitLocalWriterCliRepository.get_instance(
            squash_task_commits_dto.repo_path
        )

        base_branch = (
            squash_task_commits_dto.base_branch
            or git_local_reader_cli_repository.get_base_branch()
        )
        if not base_branch:
            raise GitException.base_branch_not_found(squash_task_commits_dto.repo_path)

        shas = git_local_reader_cli_repository.get_task_commit_shas(
            squash_task_commits_dto.task_id,
            base_branch,
            squash_task_commits_dto.source_branch,
        )
        if not shas:
            raise GitException.no_task_commits(squash_task_commits_dto.task_id)

        if squash_task_commits_dto.integration_branch:
            git_local_writer_cli_repository.checkout(
                squash_task_commits_dto.integration_branch
            )

        for sha in shas:
            git_local_writer_cli_repository.cherry_pick_no_commit(sha)

        commit_type = (
            squash_task_commits_dto.commit_type or GitConfig.DEFAULT_COMMIT_TYPE
        )
        message = (
            f"{commit_type}({squash_task_commits_dto.task_id}): "
            f"{squash_task_commits_dto.title}\n\n"
            f"Related work items: #{squash_task_commits_dto.task_id}"
        )
        git_local_writer_cli_repository.commit(message)

        commit_sha = git_local_reader_cli_repository.get_head_sha()

        return SquashTaskCommitsResultDto.from_primitives({
            "commit_sha": commit_sha,
            "message": message,
            "squashed_count": len(shas),
        })
