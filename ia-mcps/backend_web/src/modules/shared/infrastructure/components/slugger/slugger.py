"""Slugger component for converting text to URL-friendly slugs."""

import re
import unicodedata
from datetime import datetime
from typing import final, Self


@final
class Slugger:
    """Component for generating slugs from text."""

    _instance: "Slugger | None" = None

    @classmethod
    def get_instance(cls) -> Self:
        """Returns the singleton instance."""
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def slugify(self, text: str, max_length: int = 25) -> str:
        """
        Converts text to a URL-friendly slug.

        Args:
            text: Text to convert
            max_length: Maximum length of the slug

        Returns:
            str: Slugified text (lowercase, only English characters, hyphens)
        """
        # Normalize unicode characters to ASCII
        text = unicodedata.normalize("NFKD", text)
        text = text.encode("ascii", "ignore").decode("ascii")

        # Convert to lowercase
        text = text.lower()

        # Replace spaces and underscores with hyphens
        text = re.sub(r"[\s_]+", "-", text)

        # Remove all non-alphanumeric characters except hyphens
        text = re.sub(r"[^a-z0-9-]+", "", text)

        # Remove multiple consecutive hyphens
        text = re.sub(r"-+", "-", text)

        # Remove leading/trailing hyphens
        text = text.strip("-")

        # Truncate to max_length
        if len(text) > max_length:
            text = text[:max_length].rstrip("-")

        return text

    def slugify_with_timestamp(
        self, text: str, max_length: int = 25, timestamp_format: str = "%Y%m%d-%H%M%S"
    ) -> str:
        """
        Converts text to slug and appends timestamp.

        Args:
            text: Text to convert
            max_length: Maximum length of the slug (before timestamp)
            timestamp_format: Format for timestamp (default: yyyymmdd-hhmmss)

        Returns:
            str: Slugified text with timestamp (e.g., "hello-world-20260606-143022")
        """
        slug = self.slugify(text, max_length)
        timestamp = datetime.now().strftime(timestamp_format)
        return f"{slug}-{timestamp}"
