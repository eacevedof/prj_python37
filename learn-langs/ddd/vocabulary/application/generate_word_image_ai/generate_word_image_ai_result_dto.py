"""DTO de resultado para GenerateWordImageAiService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class GenerateWordImageAiResultDto:
    """DTO de resultado al generar imagen con IA."""

    image_id: int = 0
    word_id: int = 0
    file_path: str = ""
    dalle_url: str = ""
    prompt_used: str = ""
    error_message: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            image_id=int(primitives.get("image_id", 0)),
            word_id=int(primitives.get("word_id", 0)),
            file_path=str(primitives.get("file_path", "")),
            dalle_url=str(primitives.get("dalle_url", "")),
            prompt_used=str(primitives.get("prompt_used", "")),
            error_message=primitives.get("error_message"),
        )

    @classmethod
    def ok(cls, image_id: int, word_id: int, file_path: str, dalle_url: str, prompt_used: str) -> Self:
        return cls.from_primitives({
            "image_id": image_id,
            "word_id": word_id,
            "file_path": file_path,
            "dalle_url": dalle_url,
            "prompt_used": prompt_used,
        })

    @classmethod
    def error(cls, message: str) -> Self:
        return cls.from_primitives({
            "error_message": message,
        })

    @property
    def success(self) -> bool:
        return self.error_message is None
