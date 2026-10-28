"""DTO de resultado para GetWordGroupsService."""

from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class GetWordGroupsResultDto:
    """DTO de resultado para obtener grupos de palabras."""

    groups: tuple[dict[str, Any], ...] = field(default_factory=tuple)
    error_message: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        groups_data = primitives.get("groups", []) or []
        return cls(
            groups=tuple(groups_data),
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
