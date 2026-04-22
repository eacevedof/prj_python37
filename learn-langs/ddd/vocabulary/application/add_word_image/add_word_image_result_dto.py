"""DTO de resultado para AddWordImageService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class AddWordImageResultDto:
    """DTO de resultado al agregar imagen."""

    image_id: int = 0
    word_id: int = 0
    file_path: str = ""
    error_message: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            image_id=int(primitives.get("image_id", 0)),
            word_id=int(primitives.get("word_id", 0)),
            file_path=str(primitives.get("file_path", "")),
            error_message=primitives.get("error_message"),
        )

    @classmethod
    def ok(cls, image_id: int, word_id: int, file_path: str) -> Self:
        return cls.from_primitives({
            "image_id": image_id,
            "word_id": word_id,
            "file_path": file_path,
        })

    @classmethod
    def error(cls, message: str) -> Self:
        return cls.from_primitives({
            "error_message": message,
        })

    @property
    def success(self) -> bool:
        return self.error_message is None
