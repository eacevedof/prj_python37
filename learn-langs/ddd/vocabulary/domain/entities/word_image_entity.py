"""Entidad de imagen de palabra."""

from dataclasses import dataclass
from typing import Self, Any

from ddd.vocabulary.domain.enums import ImageSourceEnum


@dataclass(slots=True)
class WordImageEntity:
    """Entidad que representa una imagen asociada a una palabra."""

    id: int
    word_es_id: int
    source_type: ImageSourceEnum
    file_path: str
    mime_type: str

    # Opcionales
    original_url: str | None = None
    original_filename: str | None = None
    width: int | None = None
    height: int | None = None
    file_size: int | None = None
    svg_content: str | None = None
    caption: str | None = None
    alt_text: str | None = None
    sort_order: int = 0
    is_primary: bool = False
    is_active: bool = True
    created_at: str | None = None
    updated_at: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        """Crea la entidad desde un diccionario."""
        return cls(
            id=int(primitives.get("id", 0)),
            word_es_id=int(primitives.get("word_es_id", 0)),
            source_type=ImageSourceEnum(primitives.get("source_type", "LOCAL")),
            file_path=str(primitives.get("file_path", "")),
            mime_type=str(primitives.get("mime_type", "image/png")),
            original_url=primitives.get("original_url"),
            original_filename=primitives.get("original_filename"),
            width=primitives.get("width"),
            height=primitives.get("height"),
            file_size=primitives.get("file_size"),
            svg_content=primitives.get("svg_content"),
            caption=primitives.get("caption"),
            alt_text=primitives.get("alt_text"),
            sort_order=int(primitives.get("sort_order", 0)),
            is_primary=bool(primitives.get("is_primary", False)),
            is_active=bool(primitives.get("is_active", True)),
            created_at=primitives.get("created_at"),
            updated_at=primitives.get("updated_at"),
        )

    def to_dict(self) -> dict[str, Any]:
        """Convierte la entidad a diccionario."""
        return {
            "id": self.id,
            "word_es_id": self.word_es_id,
            "source_type": self.source_type.value,
            "file_path": self.file_path,
            "mime_type": self.mime_type,
            "original_url": self.original_url,
            "original_filename": self.original_filename,
            "width": self.width,
            "height": self.height,
            "file_size": self.file_size,
            "svg_content": self.svg_content,
            "caption": self.caption,
            "alt_text": self.alt_text,
            "sort_order": self.sort_order,
            "is_primary": self.is_primary,
            "is_active": self.is_active,
            "created_at": self.created_at,
            "updated_at": self.updated_at,
        }

    @property
    def is_vectorial(self) -> bool:
        """Indica si la imagen es vectorial."""
        return self.source_type == ImageSourceEnum.VECTORIAL or self.mime_type == "image/svg+xml"

    @property
    def full_path(self) -> str:
        """Retorna la ruta completa de la imagen."""
        from pathlib import Path
        base_path = Path(__file__).parent.parent.parent.parent.parent / "data" / "images"
        return str(base_path / self.file_path)
