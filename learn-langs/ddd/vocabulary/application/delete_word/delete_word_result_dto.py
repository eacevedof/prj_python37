"""DTO de resultado de eliminar una palabra."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class DeleteWordResultDto:
    """Output DTO con el resultado de la eliminacion."""

    word_id: int
    text: str
    images_deleted: int = 0
    translations_deleted: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            word_id=int(primitives.get("word_id", 0)),
            text=str(primitives.get("text", "")),
            images_deleted=int(primitives.get("images_deleted", 0)),
            translations_deleted=int(primitives.get("translations_deleted", 0)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "word_id": self.word_id,
            "text": self.text,
            "images_deleted": self.images_deleted,
            "translations_deleted": self.translations_deleted,
        }
