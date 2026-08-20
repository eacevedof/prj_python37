"""Video fetcher repositories."""

from src.modules.video_mod.infrastructure.repositories.video_downloader_repository import VideoDownloaderRepository
from src.modules.video_mod.infrastructure.repositories.blob_video_downloader_repository import BlobVideoDownloaderRepository

__all__ = [
    "VideoDownloaderRepository",
    "BlobVideoDownloaderRepository",
]
