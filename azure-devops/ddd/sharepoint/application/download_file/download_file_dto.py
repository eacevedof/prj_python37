from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class DownloadFileDto:
    """Input DTO for downloading a file from SharePoint."""

    file_path: str
    site_id: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        file_path = str(primitives.get("file_path", "")).strip()

        site_id = primitives.get("site_id")
        if site_id is not None:
            site_id = str(site_id).strip() or None

        return cls(
            file_path=file_path,
            site_id=site_id,
        )
