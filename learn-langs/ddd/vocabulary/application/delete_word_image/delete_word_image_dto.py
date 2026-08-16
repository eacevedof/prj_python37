"""DTO de entrada para DeleteWordImageService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class DeleteWordImageDto:
    """DTO de entrada para eliminar imagen."""

    image_id: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            image_id=int(primitives.get("image_id", 0)),
        )
