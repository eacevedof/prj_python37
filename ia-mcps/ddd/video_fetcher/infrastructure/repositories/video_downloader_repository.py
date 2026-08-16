"""Repository for downloading direct video files."""

import os
from pathlib import Path
from typing import Self, final
from urllib.parse import urlparse

import aiohttp

from ddd.shared.infrastructure.components.logger import Logger
from ddd.video_fetcher.domain.exceptions import VideoFetcherException


@final
class VideoDownloaderRepository:
    """Repository for downloading direct mp4 videos."""

    _logger: Logger
    _instance: "VideoDownloaderRepository | None" = None

    def __init__(self) -> None:
        self._logger = Logger.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def download_direct_video(
        self,
        url: str,
        output_path: str,
        headers: dict[str, str] | None = None,
    ) -> dict[str, int | str]:
        """
        Downloads a direct video file from URL.

        Args:
            url: Direct URL to video file
            output_path: Full path where to save the file
            headers: Optional HTTP headers

        Returns:
            dict with file_path and file_size_bytes

        Raises:
            VideoFetcherException: If download fails
        """
        async with aiohttp.ClientSession() as session:
            async with session.get(url, headers=headers) as response:
                if response.status != 200:
                    VideoFetcherException.unexpected_custom(
                        f"Failed to download video: HTTP {response.status}"
                    )

                output_dir = Path(output_path).parent
                output_dir.mkdir(parents=True, exist_ok=True)

                with open(output_path, "wb") as f:
                    async for chunk in response.content.iter_chunked(8192):
                        f.write(chunk)

                file_size = os.path.getsize(output_path)
                self._logger.log_info(
                    "VideoDownloaderRepository",
                    f"Downloaded video: {output_path} ({file_size} bytes)"
                )

                return {
                    "file_path": output_path,
                    "file_size_bytes": file_size,
                }


    def get_filename_from_url(self, url: str) -> str:
        """Extract filename from URL or generate one."""
        parsed = urlparse(url)
        filename = os.path.basename(parsed.path)
        if not filename or "." not in filename:
            filename = "video.mp4"
        return filename
