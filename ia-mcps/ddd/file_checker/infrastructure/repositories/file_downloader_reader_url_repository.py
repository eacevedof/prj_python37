import os
import urllib.request
from pathlib import Path
from typing import Self, final
from urllib.parse import urlparse

from ddd.shared.infrastructure.components.slugger import Slugger
from ddd.shared.infrastructure.repositories.environment_reader_raw_repository import (
    EnvironmentReaderRawRepository,
)
from ddd.file_checker.domain.enums.hash import FileCheckerHashConstantsEnum


@final
class FileDownloaderReaderUrlRepository:
    """Reader repository for downloading files from URLs to disk."""

    _instance: "FileDownloaderReaderUrlRepository | None" = None

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def __init__(self) -> None:
        pass

    def download(self, url: str) -> str:
        """Download file from URL to MEDIA_OUTPUT_DIR.

        Args:
            url: HTTP/HTTPS URL to download.

        Returns:
            Local file path where the file was saved.

        Raises:
            OSError: If output dir cannot be created.
            urllib.error.URLError: If download fails.
        """
        output_dir = EnvironmentReaderRawRepository.get_instance().get_media_output_dir()
        Path(output_dir).mkdir(parents=True, exist_ok=True)

        filename = self._extract_filename_from_url(url)
        slugified = Slugger.get_instance().slugify_with_timestamp(filename)
        file_path = os.path.join(output_dir, slugified)

        with urllib.request.urlopen(url) as response:
            with open(file_path, "wb") as f:
                while True:
                    chunk = response.read(FileCheckerHashConstantsEnum.CHUNK_SIZE)
                    if not chunk:
                        break
                    f.write(chunk)

        return file_path

    @staticmethod
    def _extract_filename_from_url(url: str) -> str:
        """Extract filename from URL path."""
        parsed = urlparse(url)
        filename = os.path.basename(parsed.path).strip("/")
        return filename if filename else "download"
