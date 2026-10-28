"""DTO de entrada para AddWordImageService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class AddWordImageDto:
    """DTO de entrada para agregar imagen a palabra."""

    word_id: int = 0
    source_type: str = "URL"  # URL, LOCAL
    url: str | None = None
    file_path: str | None = None
    filename: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            word_id=int(primitives.get("word_id", 0)),
            source_type=str(primitives.get("source_type", "URL")),
            url=primitives.get("url"),
            file_path=primitives.get("file_path"),
            filename=primitives.get("filename"),
        )

    @classmethod
    def from_url(cls, word_id: int, url: str) -> Self:
        return cls.from_primitives({
            "word_id": word_id,
            "source_type": "URL",
            "url": url,
        })

    @classmethod
    def from_file(cls, word_id: int, file_path: str, filename: str) -> Self:
        return cls.from_primitives({
            "word_id": word_id,
            "source_type": "LOCAL",
            "file_path": file_path,
            "filename": filename,
        })
