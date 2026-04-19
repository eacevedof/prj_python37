"""DTO de vista para Study."""

from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(slots=True)
class StudyViewDto:
    """DTO que el Controller pasa a la Vista de estudio."""

    # Estado de la sesion
    session_id: int = 0
    lang_code: str = ""
    total_words: int = 0
    current_index: int = 0

    # Palabra actual
    current_word: dict[str, Any] | None = None

    # Stats acumulados
    total_score: float = 0.0
    answers_count: int = 0
    avg_score_percent: int = 0

    # Resultado de ultima respuesta
    last_result: dict[str, Any] | None = None

    # Estados de la vista
    is_loading: bool = True
    is_session_complete: bool = False
    has_no_words: bool = False
    error_message: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        total_score = float(primitives.get("total_score", 0.0))
        answers_count = int(primitives.get("answers_count", 0))
        avg_score_percent = int((total_score / answers_count * 100)) if answers_count > 0 else 0

        return cls(
            session_id=int(primitives.get("session_id", 0)),
            lang_code=str(primitives.get("lang_code", "")),
            total_words=int(primitives.get("total_words", 0)),
            current_index=int(primitives.get("current_index", 0)),
            current_word=primitives.get("current_word"),
            total_score=total_score,
            answers_count=answers_count,
            avg_score_percent=avg_score_percent,
            last_result=primitives.get("last_result"),
            is_loading=bool(primitives.get("is_loading", False)),
            is_session_complete=bool(primitives.get("is_session_complete", False)),
            has_no_words=bool(primitives.get("has_no_words", False)),
            error_message=primitives.get("error_message"),
        )

    @classmethod
    def initial(cls) -> Self:
        """DTO inicial - cargando."""
        return cls.from_primitives({
            "is_loading": True,
        })

    @classmethod
    def no_words(cls) -> Self:
        """DTO cuando no hay palabras para estudiar."""
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
    def studying(
        cls,
        session_id: int,
        lang_code: str,
        total_words: int,
        current_index: int,
        current_word: dict[str, Any],
        total_score: float,
        answers_count: int,
    ) -> Self:
        """DTO para estado de estudio activo."""
        return cls.from_primitives({
            "session_id": session_id,
            "lang_code": lang_code,
            "total_words": total_words,
            "current_index": current_index,
            "current_word": current_word,
            "total_score": total_score,
            "answers_count": answers_count,
            "is_loading": False,
        })

    @classmethod
    def with_result(
        cls,
        session_id: int,
        lang_code: str,
        total_words: int,
        current_index: int,
        current_word: dict[str, Any],
        total_score: float,
        answers_count: int,
        last_result: dict[str, Any],
    ) -> Self:
        """DTO con resultado de respuesta."""
        return cls.from_primitives({
            "session_id": session_id,
            "lang_code": lang_code,
            "total_words": total_words,
            "current_index": current_index,
            "current_word": current_word,
            "total_score": total_score,
            "answers_count": answers_count,
            "last_result": last_result,
            "is_loading": False,
        })

    @classmethod
    def session_complete(
        cls,
        total_score: float,
        answers_count: int,
    ) -> Self:
        """DTO para sesion completada."""
        return cls.from_primitives({
            "total_score": total_score,
            "answers_count": answers_count,
            "is_loading": False,
            "is_session_complete": True,
        })
