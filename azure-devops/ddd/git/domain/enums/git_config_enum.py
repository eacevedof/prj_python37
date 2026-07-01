from typing import final


@final
class GitConfig:
    """Configuration constants for local git integration-branch operations."""

    INTEGRATION_BRANCH_PREFIX = "int-"
    DEFAULT_BASE_BRANCHES = ("main", "master")
    DEFAULT_COMMIT_TYPE = "feat"
    DEFAULT_REMOTE = "origin"
