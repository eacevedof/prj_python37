"""Repository for downloading blob/fragmented videos."""

import os
import re
from pathlib import Path
from typing import Self, final

import aiohttp

from ddd.shared.infrastructure.components.logger import Logger
from ddd.video_fetcher.domain.exceptions import VideoFetcherException


@final
class BlobVideoDownloaderRepository:
    """Repository for downloading blob/fragmented videos (like LinkedIn)."""

    _logger: Logger
    _instance: "BlobVideoDownloaderRepository | None" = None

    def __init__(self) -> None:
        self._logger = Logger.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def download_blob_video(
        self,
        base_url: str,
        output_path: str,
        headers: dict[str, str] | None = None,
    ) -> dict[str, int | str]:
        """
        Downloads a blob/fragmented video and merges fragments.

        Args:
            base_url: Base URL (can be blob: URL or m3u8 manifest URL)
            output_path: Full path where to save the merged file
            headers: Optional HTTP headers

        Returns:
            dict with file_path, file_size_bytes, and fragments_count

        Raises:
            VideoFetcherException: If download fails
        """

        # Check if it's a blob URL
        if base_url.startswith("blob:"):
            VideoFetcherException.bad_request_custom(
                "Direct blob: URLs cannot be downloaded. "
                "You need to extract the actual video URLs from the page source."
            )

        # Check if it's an m3u8 manifest
        if ".m3u8" in base_url:
            return await self._download_m3u8_video(base_url, output_path, headers)

        # Otherwise, try to download as direct URL
        VideoFetcherException.bad_request_custom(
            "Unable to determine video type. "
            "Supported: m3u8 manifests. "
            "For blob URLs, extract actual fragment URLs first."
        )

    async def _download_m3u8_video(
        self,
        m3u8_url: str,
        output_path: str,
        headers: dict[str, str] | None = None,
    ) -> dict[str, int | str]:
        """Download and merge HLS/m3u8 video fragments."""
        async with aiohttp.ClientSession() as session:
            # Download manifest
            async with session.get(m3u8_url, headers=headers) as response:
                if response.status != 200:
                    VideoFetcherException.unexpected_custom(
                        f"Failed to download m3u8 manifest: HTTP {response.status}"
                    )
                manifest_content = await response.text()

            # Parse fragment URLs from manifest
            fragment_urls = self._parse_m3u8_manifest(manifest_content, m3u8_url)
            if not fragment_urls:
                VideoFetcherException.unexpected_custom("No fragments found in m3u8 manifest")

            self._logger.log_info(
                "BlobVideoDownloaderRepository",
                f"Found {len(fragment_urls)} fragments to download"
            )

            # Create output directory
            output_dir = Path(output_path).parent
            output_dir.mkdir(parents=True, exist_ok=True)

            # Download and merge fragments
            with open(output_path, "wb") as output_file:
                for i, fragment_url in enumerate(fragment_urls, 1):
                    async with session.get(fragment_url, headers=headers) as frag_response:
                        if frag_response.status != 200:
                            self._logger.log_error(
                                "BlobVideoDownloaderRepository",
                                f"Failed to download fragment {i}/{len(fragment_urls)}: HTTP {frag_response.status}"
                            )
                            continue

                        fragment_data = await frag_response.read()
                        output_file.write(fragment_data)

                    if i % 10 == 0:
                        self._logger.log_info(
                            "BlobVideoDownloaderRepository",
                            f"Downloaded {i}/{len(fragment_urls)} fragments"
                        )

            file_size = os.path.getsize(output_path)
            self._logger.log_info(
                "BlobVideoDownloaderRepository",
                f"Merged video saved: {output_path} ({file_size} bytes, {len(fragment_urls)} fragments)"
            )

            return {
                "file_path": output_path,
                "file_size_bytes": file_size,
                "fragments_count": len(fragment_urls),
            }


    def _parse_m3u8_manifest(self, manifest_content: str, base_url: str) -> list[str]:
        """Parse m3u8 manifest and extract fragment URLs."""
        fragment_urls = []
        base_path = "/".join(base_url.split("/")[:-1])

        for line in manifest_content.split("\n"):
            line = line.strip()
            # Skip comments and empty lines
            if not line or line.startswith("#"):
                continue

            # Build full URL for relative paths
            if line.startswith("http://") or line.startswith("https://"):
                fragment_urls.append(line)
            else:
                fragment_urls.append(f"{base_path}/{line}")

        return fragment_urls
