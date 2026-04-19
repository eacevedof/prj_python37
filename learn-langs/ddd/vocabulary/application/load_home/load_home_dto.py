"""Input DTO para cargar datos del home."""

from dataclasses import dataclass
from typing import Self, Any

from ddd.vocabulary.domain.enums import LanguageCodeEnum


@dataclass(frozen=True, slots=True)
class LoadHomeDto:
    """Input DTO para cargar datos del home."""

    lang_code: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        lang_code = str(primitives.get("lang_code", ""))
        if not lang_code:
            lang_code = LanguageCodeEnum.default().value
        return cls(lang_code=lang_code)

    @classmethod
    def default(cls) -> Self:
        """Crea un DTO con valores por defecto."""
        return cls(lang_code=LanguageCodeEnum.default().value)
