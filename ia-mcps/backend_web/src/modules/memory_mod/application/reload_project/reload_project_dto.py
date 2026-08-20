from dataclasses import dataclass


@dataclass(frozen=True, slots=True)
class ReloadProjectDto:
    project_name: str
    project_root: str
    include_git_history: bool = True
    include_dependencies: bool = True
    max_recent_commits: int = 20
