"""DTO de resultado para GetWordForEditService."""

from dataclasses import dataclass, field
from typing import Self, Any

from ddd.vocabulary.domain.enums import WordTypeEnum


@dataclass(frozen=True, slots=True)
class GetWordForEditResultDto:
    """DTO de resultado con datos de la palabra para editar."""

    word_id: int = 0
    text: str = ""
    word_type: str = WordTypeEnum.WORD.value
    notes: str = ""
    translations: dict[str, str] = field(default_factory=dict)
    selected_tags: tuple[str, ...] = field(default_factory=tuple)
    available_tags: tuple[dict[str, Any], ...] = field(default_factory=tuple)
    error_message: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        translations = primitives.get("translations", {}) or {}
        selected_tags = primitives.get("selected_tags", []) or []
        available_tags_raw = primitives.get("available_tags", []) or []

        return cls(
            word_id=int(primitives.get("word_id", 0)),
            text=str(primitives.get("text", "")),
            word_type=str(primitives.get("word_type", WordTypeEnum.WORD.value)),
            notes=str(primitives.get("notes", "") or ""),
            translations=dict(translations),
            selected_tags=tuple(selected_tags),
            available_tags=tuple(available_tags_raw),
            error_message=primitives.get("error_message"),
        )

    @classmethod
    def not_found(cls, word_id: int) -> Self:
        return cls.from_primitives({
            "error_message": f"Palabra #{word_id} no encontrada",
        })

    @classmethod
    def error(cls, message: str) -> Self:
        return cls.from_primitives({
            "error_message": message,
        })

    @classmethod
    def ok(
        cls,
        word_id: int,
        text: str,
        word_type: str,
        notes: str,
        translations: dict[str, str],
        selected_tags: list[str],
        available_tags: list[dict[str, Any]],
    ) -> Self:
        """Factory method for successful result."""
        return cls.from_primitives({
            "word_id": word_id,
            "text": text,
            "word_type": word_type,
            "notes": notes,
            "translations": translations,
            "selected_tags": selected_tags,
            "available_tags": available_tags,
            "error_message": None,
        })

    @property
    def success(self) -> bool:
        return self.error_message is None
