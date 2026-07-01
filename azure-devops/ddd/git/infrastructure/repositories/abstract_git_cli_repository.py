import subprocess
from abc import ABC


class AbstractGitCliRepository(ABC):
    """Base repository for local git operations run through the ``git`` CLI.

    Every command is executed against ``repo_path`` using ``git -C <path>`` so a
    single instance is bound to one working copy. Commands run with
    ``check=True``; a failing command raises ``CalledProcessError`` which is
    allowed to propagate (repositories never catch — only the controller does).
    """

    def __init__(self, repo_path: str) -> None:
        self._repo_path = repo_path

    def _run_git(self, *args: str) -> str:
        """Run a git command against the bound repository and return stdout.

        Args:
            *args: Arguments passed to git after ``-C <repo_path>``.

        Returns:
            The trimmed standard output of the command.

        Raises:
            subprocess.CalledProcessError: If git exits with a non-zero status.
        """
        completed_process = subprocess.run(
            ["git", "-C", self._repo_path, *args],
            check=True,
            capture_output=True,
            text=True,
        )
        return completed_process.stdout.strip()
