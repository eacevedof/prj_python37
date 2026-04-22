"""DTO de resultado para GetWordImagesService."""

from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class WordImageDto:
    """DTO para una imagen."""

    id: int = 0
    word_es_id: int = 0
    file_path: str = ""
    source_type: str = ""
    is_primary: bool = False

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            id=int(primitives.get("id", 0)),
            word_es_id=int(primitives.get("word_es_id", 0)),
            file_path=str(primitives.get("file_path", "")),
            source_type=str(primitives.get("source_type", "")),
            is_primary=bool(primitives.get("is_primary", False)),
        )


@dataclass(frozen=True, slots=True)
class GetWordImagesResultDto:
    """DTO de resultado con las imagenes."""

    images: tuple[WordImageDto, ...] = field(default_factory=tuple)
    error_message: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        images_raw = primitives.get("images", []) or []
        images = tuple(
            img if isinstance(img, WordImageDto) else WordImageDto.from_primitives(img)
            for img in images_raw
        )
        return cls(
            images=images,
            error_message=primitives.get("error_message"),
        )

    @classmethod
    def ok(cls, images: list[WordImageDto]) -> Self:
        return cls.from_primitives({"images": images})

    @classmethod
    def error(cls, message: str) -> Self:
        return cls.from_primitives({"error_message": message})

    @property
    def success(self) -> bool:
        return self.error_message is None

    def to_list_of_dicts(self) -> list[dict[str, Any]]:
        """Convierte imagenes a lista de dicts para la vista."""
        return [
            {
                "id": img.id,
                "word_es_id": img.word_es_id,
                "file_path": img.file_path,
                "source_type": img.source_type,
                "is_primary": img.is_primary,
            }
            for img in self.images
        ]
