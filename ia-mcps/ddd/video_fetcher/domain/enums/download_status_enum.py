"""Enum for download status."""

from enum import StrEnum


class DownloadStatusEnum(StrEnum):
    """Download status types."""

    SUCCESS = "success"
    PARTIAL = "partial"
    FAILED = "failed"

    def __iter__(self):
        return iter([self.SUCCESS, self.PARTIAL, self.FAILED])
