from typing import final


@final
class SharePointException(Exception):
    """Exception for SharePoint operations."""

    def __init__(self, message: str) -> None:
        self.message = message
        super().__init__(self.message)

    @classmethod
    def authentication_failed(cls, detail: str = "") -> "SharePointException":
        msg = "SharePoint authentication failed"
        if detail:
            msg = f"{msg}: {detail}"
        return cls(msg)

    @classmethod
    def token_expired(cls) -> "SharePointException":
        return cls("SharePoint access token has expired")

    @classmethod
    def file_not_found(cls, path: str) -> "SharePointException":
        return cls(f"File not found: {path}")

    @classmethod
    def folder_not_found(cls, path: str) -> "SharePointException":
        return cls(f"Folder not found: {path}")

    @classmethod
    def upload_failed(cls, path: str, detail: str = "") -> "SharePointException":
        msg = f"Failed to upload file: {path}"
        if detail:
            msg = f"{msg} - {detail}"
        return cls(msg)

    @classmethod
    def download_failed(cls, path: str, detail: str = "") -> "SharePointException":
        msg = f"Failed to download file: {path}"
        if detail:
            msg = f"{msg} - {detail}"
        return cls(msg)

    @classmethod
    def delete_failed(cls, path: str, detail: str = "") -> "SharePointException":
        msg = f"Failed to delete file: {path}"
        if detail:
            msg = f"{msg} - {detail}"
        return cls(msg)

    @classmethod
    def api_error(cls, status_code: int, detail: str = "") -> "SharePointException":
        msg = f"SharePoint API error (HTTP {status_code})"
        if detail:
            msg = f"{msg}: {detail}"
        return cls(msg)

    @classmethod
    def site_not_found(cls, site_id: str) -> "SharePointException":
        return cls(f"SharePoint site not found: {site_id}")

    @classmethod
    def invalid_path(cls, path: str) -> "SharePointException":
        return cls(f"Invalid file path: {path}")
