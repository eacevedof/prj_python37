import re
from typing import final, Self, Any
from dataclasses import dataclass

from ddd.devops.domain.enums.local_project_const import LocalProjectConst


@final
@dataclass(frozen=True, slots=True)
class SetupProjectDto:
    """DTO for setting up a new local project."""

    project_name: str
    repo_url: str
    db_name: str
    port: int | None

    @classmethod
    def from_primitives(cls, primitives_dict: dict[str, Any]) -> Self:
        raw_project_name = primitives_dict.get("project_name", "")
        normalized_proj_name = re.sub(r"[^a-z0-9-]", "-", raw_project_name.lower())

        db_name = primitives_dict.get("db_name") or ""
        if not db_name:
            db_name = f"{LocalProjectConst.DATABASE_NAME_PREFIX}{normalized_proj_name.replace('-', '_')}"

        return cls(
            project_name=normalized_proj_name,
            repo_url=primitives_dict.get("repo_url", ""),
            db_name=db_name,
            port=primitives_dict.get("port"),
        )
