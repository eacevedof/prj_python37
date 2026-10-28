from typing import final

from ddd.shared.domain.exceptions.domain_exception import DomainException


@final
class GitException(DomainException):
    """Exception for local git CLI operations."""

    def __init__(self, message: str) -> None:
        self.message = message
        super().__init__(self.message)

    @classmethod
    def not_a_git_repo(cls, path: str) -> "GitException":
        return cls(f"Not a git repository: {path}")

    @classmethod
    def base_branch_not_found(cls, path: str) -> "GitException":
        return cls(f"No base branch (main/master) found in repository: {path}")

    @classmethod
    def no_task_commits(cls, task_id: int) -> "GitException":
        return cls(f"No commits found for task: {task_id}")

    @classmethod
    def cherry_pick_conflict(cls, sha: str) -> "GitException":
        return cls(f"Cherry-pick conflict on commit: {sha}")
