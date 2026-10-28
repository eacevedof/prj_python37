"""DTO de resultado para DeleteWordGroupService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class DeleteWordGroupResultDto:
    """DTO de resultado al eliminar un grupo de palabras."""

    group_id: int = 0
    title: str = ""
    error_message: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            group_id=int(primitives.get("group_id", 0)),
            title=str(primitives.get("title", "")),
            error_message=primitives.get("error_message"),
        )

    # @deuda: el caso de uso devuelve este ResultDto de error en vez de lanzar
    # VocabularyException para que el controller la capture (migrar a raise + catch).
    @classmethod
    def error(cls, message: str) -> Self:
        return cls.from_primitives({"error_message": message})

    @property
    def success(self) -> bool:
        return self.error_message is None
