import os
from typing import final, Self, Any

from ddd.git.domain.enums.git_config_enum import GitConfig
from ddd.git.infrastructure.repositories.abstract_git_cli_repository import (
    AbstractGitCliRepository,
)


@final
class GitLocalReaderCliRepository(AbstractGitCliRepository):
    """Read-only repository for inspecting a local git working copy."""

    @classmethod
    def get_instance(cls, repo_path: str) -> Self:
        return cls(repo_path)

    def is_git_repo(self) -> bool:
        """Check whether the bound path is a git repository.

        Uses the filesystem (no subprocess) so it returns cleanly instead of
        raising when the path is not a repository.
        """
        return os.path.isdir(os.path.join(self._repo_path, ".git"))

    def branch_exists(self, name: str) -> bool:
        """Return True if a local branch with the given name exists."""
        return bool(self._run_git("branch", "--list", name))

    def get_base_branch(self) -> str:
        """Return the first existing default base branch, or empty if none."""
        for base_branch in GitConfig.DEFAULT_BASE_BRANCHES:
            if self.branch_exists(base_branch):
                return base_branch
        return ""

    def get_current_branch(self) -> str:
        """Return the short name of the currently checked-out branch."""
        return self._run_git("rev-parse", "--abbrev-ref", "HEAD")

    def get_head_sha(self) -> str:
        """Return the full commit sha currently at HEAD."""
        return self._run_git("rev-parse", "HEAD")

    def get_task_commit_shas(
        self, task_id: int, base_branch: str, source_branch: str
    ) -> list[str]:
        """Return the shas of a task's commits in ``base..source`` order.

        Matches commits whose message references ``#{task_id}``; if none match,
        retries with the ``task-{task_id}`` reference. May return an empty list.
        """
        shas = self._log_shas(task_id, base_branch, source_branch, f"#{task_id}")
        if not shas:
            shas = self._log_shas(
                task_id, base_branch, source_branch, f"task-{task_id}"
            )
        return shas

    def get_task_commit_summaries(
        self, task_id: int, base_branch: str, source_branch: str
    ) -> list[dict[str, Any]]:
        """Return ``{sha, subject}`` entries for a task's commits (oldest first)."""
        summaries = self._log_summaries(
            task_id, base_branch, source_branch, f"#{task_id}"
        )
        if not summaries:
            summaries = self._log_summaries(
                task_id, base_branch, source_branch, f"task-{task_id}"
            )
        return summaries

    def _log_shas(
        self, task_id: int, base_branch: str, source_branch: str, grep: str
    ) -> list[str]:
        output = self._run_git(
            "log",
            f"{base_branch}..{source_branch}",
            f"--grep={grep}",
            "--format=%H",
            "--reverse",
        )
        return [line for line in output.splitlines() if line.strip()]

    def _log_summaries(
        self, task_id: int, base_branch: str, source_branch: str, grep: str
    ) -> list[dict[str, Any]]:
        output = self._run_git(
            "log",
            f"{base_branch}..{source_branch}",
            f"--grep={grep}",
            "--format=%H%x1f%s",
            "--reverse",
        )
        summaries: list[dict[str, Any]] = []
        for line in output.splitlines():
            if not line.strip():
                continue
            sha, _, subject = line.partition("\x1f")
            summaries.append({"sha": sha, "subject": subject})
        return summaries
