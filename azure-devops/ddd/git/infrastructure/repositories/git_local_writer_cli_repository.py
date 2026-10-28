import base64
from typing import final, Self

from ddd.shared.infrastructure.repositories.environment_reader_env_repository import (
    EnvironmentReaderEnvRepository,
)
from ddd.git.infrastructure.repositories.abstract_git_cli_repository import (
    AbstractGitCliRepository,
)


@final
class GitLocalWriterCliRepository(AbstractGitCliRepository):
    """Write repository that mutates a local git working copy."""

    _environment_reader_env_repository: EnvironmentReaderEnvRepository

    def __init__(self, repo_path: str) -> None:
        super().__init__(repo_path)
        self._environment_reader_env_repository = (
            EnvironmentReaderEnvRepository.get_instance()
        )

    @classmethod
    def get_instance(cls, repo_path: str) -> Self:
        return cls(repo_path)

    def create_integration_branch(self, base_branch: str, new_branch: str) -> None:
        """Refresh remotes then (re)create ``new_branch`` off ``base_branch``."""
        self._run_git("fetch", "--all", "--prune")
        self._run_git("checkout", "-B", new_branch, base_branch)

    def checkout(self, branch: str) -> None:
        """Checkout an existing branch."""
        self._run_git("checkout", branch)

    def cherry_pick_no_commit(self, sha: str) -> None:
        """Apply a commit's changes to the working tree without committing."""
        self._run_git("cherry-pick", "--no-commit", sha)

    def commit(self, message: str) -> None:
        """Create a commit with the given full message."""
        self._run_git("commit", "-m", message)

    def push_with_pat(self, remote: str, branch: str) -> None:
        """Push a branch to Azure Repos authenticating with a PAT header.

        Builds a basic ``Authorization`` header from the Azure PAT and injects
        it for a single push via ``git -c http.extraheader=...``.
        """
        azure_pat = self._environment_reader_env_repository.get_azure_pat()
        basic_token = base64.b64encode(f":{azure_pat}".encode()).decode()
        self._run_git(
            "-c",
            f"http.extraheader=Authorization: Basic {basic_token}",
            "push",
            remote,
            branch,
        )
