import re
from typing import Optional


class Slugger:
    _instance: Optional['Slugger'] = None

    def __init__(self):
        pass

    @classmethod
    def get_instance(cls) -> 'Slugger':
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def get_slugged_text(self, text: str) -> str:
        """Convert text to slug format"""
        # Trim, lowercase, replace non-alphanumeric with hyphens
        slug = text.strip().lower()
        slug = re.sub(r'[^a-z0-9]+', '-', slug)
        slug = re.sub(r'^-+|-+$', '', slug)  # Remove leading/trailing hyphens
        return slug