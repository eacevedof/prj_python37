"""Service for downloading videos."""

import os
from datetime import datetime
from pathlib import Path
from typing import Self, final

from ddd.shared.infrastructure.components import Logger, Slugger
from ddd.video_fetcher.application.download_video.download_video_dto import DownloadVideoDto
from ddd.video_fetcher.application.download_video.download_video_result_dto import DownloadVideoResultDto
from ddd.video_fetcher.domain.enums import VideoTypeEnum, DownloadStatusEnum
from ddd.video_fetcher.domain.exceptions import VideoFetcherException
from ddd.video_fetcher.infrastructure.repositories import (
    VideoDownloaderRepository,
    BlobVideoDownloaderRepository,
)


@final
class DownloadVideoService:
    """Use case to download video files (direct mp4 or blob/fragmented)."""

    _download_video_dto: DownloadVideoDto
    _logger: Logger
    _direct_downloader: VideoDownloaderRepository
    _blob_downloader: BlobVideoDownloaderRepository

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._direct_downloader = VideoDownloaderRepository.get_instance()
        self._blob_downloader = BlobVideoDownloaderRepository.get_instance()

    async def __call__(
        self,
        download_video_dto: DownloadVideoDto
    ) -> DownloadVideoResultDto:
        """
        Downloads a video from URL (direct or fragmented).

        Returns:
            DownloadVideoResultDto: Result with file path and metadata

        Raises:
            VideoFetcherException: If download fails
        """
        self._download_video_dto = download_video_dto

        video_type = self._detect_video_type(self._download_video_dto.url)

        if video_type not in (VideoTypeEnum.DIRECT_MP4, VideoTypeEnum.BLOB_FRAGMENTED, VideoTypeEnum.M3U8_HLS):
            VideoFetcherException.bad_request_custom(
                f"Unsupported video type: {video_type}"
            )

        output_path = self._get_output_path(video_type)
        result = {}
        fragments_count = 0
        if video_type == VideoTypeEnum.DIRECT_MP4:
            result = await self._direct_downloader.download_direct_video(
                url=self._download_video_dto.url,
                output_path=output_path,
                headers=self._download_video_dto.headers,
            )

        elif video_type in (VideoTypeEnum.BLOB_FRAGMENTED, VideoTypeEnum.M3U8_HLS):
            result = await self._blob_downloader.download_blob_video(
                base_url=self._download_video_dto.url,
                output_path=output_path,
                headers=self._download_video_dto.headers,
            )
            fragments_count = result.get("fragments_count", 0)


        return DownloadVideoResultDto.from_primitives({
            "file_path": result["file_path"],
            "file_size_bytes": result["file_size_bytes"],
            "video_type": video_type,
            "download_status": DownloadStatusEnum.SUCCESS,
            "fragments_count": fragments_count,
            "url": self._download_video_dto.url,
        })


    def _detect_video_type(self, url: str) -> str:
        """Detect video type from URL."""
        url_lower = url.lower()

        if ".m3u8" in url_lower:
            return VideoTypeEnum.M3U8_HLS
        elif url_lower.startswith("blob:"):
            return VideoTypeEnum.BLOB_FRAGMENTED
        elif url_lower.endswith((".mp4", ".mov", ".avi", ".mkv", ".webm")):
            return VideoTypeEnum.DIRECT_MP4
        elif "blob" in url_lower or "fragment" in url_lower:
            return VideoTypeEnum.BLOB_FRAGMENTED

        return VideoTypeEnum.DIRECT_MP4

    def _get_output_path(self, video_type: str) -> str:
        """Generate output file path."""

        output_dir = Path(os.getenv("MEDIA_OUTPUT_DIR", "./downloads"))
        if self._download_video_dto.output_dir:
            output_dir = Path(self._download_video_dto.output_dir)

        output_dir.mkdir(parents=True, exist_ok=True)

        # Determine filename
        if self._download_video_dto.filename:
            filename = self._download_video_dto.filename
        else:
            # For blob/fragmented, generate timestamp-based name
            timestamp = datetime.now().strftime("%Y%m%d-%H%M%S")
            filename = f"video-{timestamp}.mp4"

            if video_type == VideoTypeEnum.DIRECT_MP4:
                filename = self._direct_downloader.get_filename_from_url(
                    self._download_video_dto.url
                )

        return str(output_dir / filename)
