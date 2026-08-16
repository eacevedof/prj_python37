import re
import html
from typing import final, Self


@final
class Texter:

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_sanitized_primitives(self, primitives: dict[str, str | None]) -> dict[str, str | None]:
        return {
            key: self._get_sanitized_value(value)
            for key, value in primitives.items()
        }

    def _get_sanitized_value(self, value: str | None) -> str | None:
        sanitized = self.get_sanitized_text(value)
        if not sanitized:
            return None
        return sanitized

    def get_no_html_text(self, text: str | None) -> str:
        if text is None:
            return ""
        text = text.strip()
        if not text:
            return ""

        text = re.sub(r"<[^>]+>", "", text)
        text = re.sub(r"[^\S\r\n]+", " ", text)
        return text.strip()

    def get_trim_lowered_text(self, text: str | None) -> str:
        if text is None:
            return ""
        text = text.strip()
        if not text:
            return ""

        text = re.sub(r"<[^>]+>", "", text)
        text = re.sub(r"[^\S\r\n]+", " ", text)
        return text.lower().strip()

    def get_sanitized_text(self, text: str | None) -> str | None:
        if text is None:
            return None
        text = text.strip()
        if not text:
            return ""

        text = re.sub(r"<[^>]+>", "", text)
        text = re.sub(r"[^a-zA-Z0-9áéíóúÁÉÍÓÚñÑüÜ@.,_\- \n#|+\/:]+", " ", text)
        text = re.sub(r"[^\S\r\n]+", " ", text)
        return text.strip()

    def get_text_as_utf8_from_html(self, html_text: str) -> str:
        utf8_text = html.unescape(html_text)
        return self._get_hard_replace(utf8_text)

    def get_html_decoded(self, html_text: str | None) -> str | None:
        if html_text is None:
            return None
        html_text = html_text.strip()
        if not html_text:
            return ""
        return html.unescape(html_text)

    def _get_hard_replace(self, html_text: str) -> str:
        replacements = {
            "&aacute;": "á",
            "&eacute;": "é",
            "&iacute;": "í",
            "&oacute;": "ó",
            "&uacute;": "ú",
            "&amp;": "&",
            "&quot;": "\"",
        }
        for old, new in replacements.items():
            html_text = html_text.replace(old, new)
        return html_text
