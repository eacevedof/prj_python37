import base64
from dataclasses import dataclass
from typing import Self, Any

from ddd.sharepoint.domain.exceptions.sharepoint_exception import SharePointException


@dataclass(frozen=True, slots=True)
class UploadFileDto:
    """Input DTO for uploading a file to SharePoint."""

    file_path: str
    content_base64: str
    site_id: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        file_path = str(primitives.get("file_path", "")).strip()
        content_base64 = str(primitives.get("content_base64", "")).strip()

        site_id = primitives.get("site_id")
        if site_id is not None:
            site_id = str(site_id).strip() or None

        return cls(
            file_path=file_path,
            content_base64=content_base64,
            site_id=site_id,
        )

    def get_content_bytes(self) -> bytes:
        """Decode base64 content to bytes.

        Returns:
            File content as bytes.

        Raises:
            SharePointException: If base64 decoding fails.
        """
        try:
            return base64.b64decode(self.content_base64)
        except Exception as e:
            raise SharePointException(f"Invalid base64 content: {e}")
