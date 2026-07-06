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
    img_ia_context: str = ""
    translations: dict[str, str] = field(default_factory=dict)
    translations_examples: dict[str, str] = field(default_factory=dict)  # lang_code -> ejemplos de uso
    selected_tags: tuple[str, ...] = field(default_factory=tuple)
    available_tags: tuple[dict[str, Any], ...] = field(default_factory=tuple)
    error_message: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        translations = primitives.get("translations", {}) or {}
        translations_examples = primitives.get("translations_examples", {}) or {}
        selected_tags = primitives.get("selected_tags", []) or []
        available_tags_raw = primitives.get("available_tags", []) or []

        return cls(
            word_id=int(primitives.get("word_id", 0)),
            text=str(primitives.get("text", "")),
            word_type=str(primitives.get("word_type", WordTypeEnum.WORD.value)),
            notes=str(primitives.get("notes", "") or ""),
            img_ia_context=str(primitives.get("img_ia_context", "") or ""),
            translations=dict(translations),
            translations_examples=dict(translations_examples),
            selected_tags=tuple(selected_tags),
            available_tags=tuple(available_tags_raw),
            error_message=primitives.get("error_message"),
        )

    @classmethod
    def not_found(cls, word_id: int) -> Self:
        return cls.from_primitives({
            "error_message": f"Palabra #{word_id} no encontrada",
        })

    # @deuda: el caso de uso devuelve este ResultDto de error en vez de lanzar
    # VocabularyException para que el controller la capture (migrar a raise + catch).
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
        img_ia_context: str,
        translations: dict[str, str],
        translations_examples: dict[str, str],
        selected_tags: list[str],
        available_tags: list[dict[str, Any]],
    ) -> Self:
        """Factory method for successful result."""
        return cls.from_primitives({
            "word_id": word_id,
            "text": text,
            "word_type": word_type,
            "notes": notes,
            "img_ia_context": img_ia_context,
            "translations": translations,
            "translations_examples": translations_examples,
            "selected_tags": selected_tags,
            "available_tags": available_tags,
            "error_message": None,
        })

    @property
    def success(self) -> bool:
        return self.error_message is None
