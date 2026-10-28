"""DTO de resultado para DeleteWordImageService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class DeleteWordImageResultDto:
    """DTO de resultado al eliminar imagen."""

    image_id: int = 0
    error_message: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            image_id=int(primitives.get("image_id", 0)),
            error_message=primitives.get("error_message"),
        )

    @classmethod
    def ok(cls, image_id: int) -> Self:
        return cls.from_primitives({"image_id": image_id})

    # @deuda: el caso de uso devuelve este ResultDto de error en vez de lanzar
    # VocabularyException para que el controller la capture (migrar a raise + catch).
    @classmethod
    def error(cls, message: str) -> Self:
        return cls.from_primitives({"error_message": message})

    @property
    def success(self) -> bool:
        return self.error_message is None
