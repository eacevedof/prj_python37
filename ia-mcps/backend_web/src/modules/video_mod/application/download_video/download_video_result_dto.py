"""Result DTO for video download."""

from dataclasses import dataclass
from typing import Self


@dataclass(frozen=True, slots=True)
class DownloadVideoResultDto:
    """Result DTO for video download."""

    file_path: str
    file_size_bytes: int
    video_type: str
    download_status: str
    fragments_count: int
    url: str

    @classmethod
    def from_primitives(cls, primitives: dict) -> Self:
        file_path = str(primitives.get("file_path", ""))
        file_size_bytes = int(primitives.get("file_size_bytes", 0))
        video_type = str(primitives.get("video_type", ""))
        download_status = str(primitives.get("download_status", ""))
        fragments_count = int(primitives.get("fragments_count", 0))
        url = str(primitives.get("url", ""))

        return cls(
            file_path=file_path,
            file_size_bytes=file_size_bytes,
            video_type=video_type,
            download_status=download_status,
            fragments_count=fragments_count,
            url=url,
        )
