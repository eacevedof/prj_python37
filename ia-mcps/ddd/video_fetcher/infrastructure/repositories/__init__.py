"""Video fetcher repositories."""

from ddd.video_fetcher.infrastructure.repositories.video_downloader_repository import VideoDownloaderRepository
from ddd.video_fetcher.infrastructure.repositories.blob_video_downloader_repository import BlobVideoDownloaderRepository

__all__ = [
    "VideoDownloaderRepository",
    "BlobVideoDownloaderRepository",
]
