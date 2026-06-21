"""DTO de vista para Word Slider."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class WordSliderViewDto:
    """DTO inmutable que el Controller pasa a la Vista del slider."""

    # Estado de la sesión
    session_id: int = 0
    lang_code: str = ""
    total_words: int = 0
    current_index: int = 0

    # Palabra actual (inmutable): text_es, text_lang, pronunciation
    current_word: dict[str, Any] | None = None

    # Fase de reproducción de la palabra actual
    phase_label: str = ""
    show_translation: bool = False

    # Estados de la vista
    is_loading: bool = True
    is_session_complete: bool = False
    has_no_words: bool = False
    error_message: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        current_word = primitives.get("current_word")

        return cls(
            session_id=int(primitives.get("session_id", 0)),
            lang_code=str(primitives.get("lang_code", "")),
            total_words=int(primitives.get("total_words", 0)),
            current_index=int(primitives.get("current_index", 0)),
            current_word=dict(current_word) if current_word else None,
            phase_label=str(primitives.get("phase_label", "")),
            show_translation=bool(primitives.get("show_translation", False)),
            is_loading=bool(primitives.get("is_loading", False)),
            is_session_complete=bool(primitives.get("is_session_complete", False)),
            has_no_words=bool(primitives.get("has_no_words", False)),
            error_message=primitives.get("error_message"),
        )

    @classmethod
    def initial(cls) -> Self:
        """DTO inicial - cargando."""
        return cls.from_primitives({"is_loading": True})

    @classmethod
    def no_words(cls) -> Self:
        """DTO cuando no hay palabras."""
        return cls.from_primitives({
            "is_loading": False,
            "has_no_words": True,
        })

    @classmethod
    def error(cls, message: str) -> Self:
        """DTO de error."""
        return cls.from_primitives({
            "is_loading": False,
            "error_message": message,
        })

    @classmethod
    def sliding(
        cls,
        session_id: int,
        lang_code: str,
        total_words: int,
        current_index: int,
        current_word: dict[str, Any],
        phase_label: str,
        show_translation: bool,
    ) -> Self:
        """DTO para una palabra reproduciéndose en una fase concreta."""
        return cls.from_primitives({
            "session_id": session_id,
            "lang_code": lang_code,
            "total_words": total_words,
            "current_index": current_index,
            "current_word": current_word,
            "phase_label": phase_label,
            "show_translation": show_translation,
            "is_loading": False,
        })

    @classmethod
    def session_complete(cls, total_words: int) -> Self:
        """DTO para sesión completada."""
        return cls.from_primitives({
            "total_words": total_words,
            "is_loading": False,
            "is_session_complete": True,
        })

    @property
    def progress_text(self) -> str:
        """Texto de progreso."""
        if self.is_loading:
            return "Cargando..."
        if self.total_words == 0:
            return ""
        return f"Palabra {self.current_index + 1} de {self.total_words}"
