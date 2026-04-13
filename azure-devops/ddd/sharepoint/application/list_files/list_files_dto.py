from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class ListFilesDto:
    """Input DTO for listing files in a SharePoint folder."""

    folder_path: str
    site_id: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        folder_path = str(primitives.get("folder_path", "/")).strip()
        if not folder_path:
            folder_path = "/"

        site_id = primitives.get("site_id")
        if site_id is not None:
            site_id = str(site_id).strip() or None

        return cls(
            folder_path=folder_path,
            site_id=site_id,
        )
