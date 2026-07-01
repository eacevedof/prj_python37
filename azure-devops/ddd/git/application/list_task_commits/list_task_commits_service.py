from typing import final, Self

from ddd.git.domain.exceptions.git_exception import GitException
from ddd.git.application.list_task_commits.list_task_commits_dto import (
    ListTaskCommitsDto,
)
from ddd.git.application.list_task_commits.list_task_commits_result_dto import (
    ListTaskCommitsResultDto,
)
from ddd.git.infrastructure.repositories.git_local_reader_cli_repository import (
    GitLocalReaderCliRepository,
)


@final
class ListTaskCommitsService:
    """Service that lists a task's commits between the base and source branches."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self, list_task_commits_dto: ListTaskCommitsDto
    ) -> ListTaskCommitsResultDto:
        git_local_reader_cli_repository = GitLocalReaderCliRepository.get_instance(
            list_task_commits_dto.repo_path
        )

        base_branch = (
            list_task_commits_dto.base_branch
            or git_local_reader_cli_repository.get_base_branch()
        )
        if not base_branch:
            raise GitException.base_branch_not_found(list_task_commits_dto.repo_path)

        source_branch = (
            list_task_commits_dto.source_branch
            or git_local_reader_cli_repository.get_current_branch()
        )

        commits = git_local_reader_cli_repository.get_task_commit_summaries(
            list_task_commits_dto.task_id, base_branch, source_branch
        )

        return ListTaskCommitsResultDto.from_primitives({
            "commits": commits,
            "total": len(commits),
        })
