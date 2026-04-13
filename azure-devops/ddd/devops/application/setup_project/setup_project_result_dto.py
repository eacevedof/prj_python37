from typing import final, Self
from dataclasses import dataclass


@final
@dataclass(frozen=True)
class SetupProjectResultDto:
    """Result DTO for setup project operation."""

    project_name: str
    app_folder: str
    app_path: str
    port: int
    server_name: str
    db_name: str
    url: str
    env_path: str
    steps_completed: list[str]

    @classmethod
    def from_primitives(cls, data: dict) -> Self:
        return cls(
            project_name=data["project_name"],
            app_folder=data["app_folder"],
            app_path=data["app_path"],
            port=data["port"],
            server_name=data["server_name"],
            db_name=data["db_name"],
            url=data["url"],
            env_path=data["env_path"],
            steps_completed=data["steps_completed"],
        )
