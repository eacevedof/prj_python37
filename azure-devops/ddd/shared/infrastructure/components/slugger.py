import re
from typing import final, Self


@final
class Slugger:

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_slugged_text(self, text: str) -> str:
        slug = text.lower().strip()

        replacements = {
            "á": "a", "é": "e", "í": "i", "ó": "o", "ú": "u",
            "Á": "a", "É": "e", "Í": "i", "Ó": "o", "Ú": "u",
            "ü": "u", "Ü": "u", "ñ": "n", "Ñ": "n"
        }
        for old, new in replacements.items():
            slug = slug.replace(old, new)

        slug = re.sub(r"[^a-z0-9]+", "-", slug)
        slug = re.sub(r"^-+|-+$", "", slug)

        return slug
