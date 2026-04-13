from dataclasses import dataclass
from typing import Self, Any


@dataclass(slots=True)
class WordLangEntity:
    """Entidad: traducción de palabra a otro idioma."""

    id: int
    word_es_id: int
    lang_code: str
    text: str
    pronunciation: str = ""
    audio_path: str = ""
    notes: str = ""
    created_at: str = ""
    updated_at: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            id=int(primitives.get("id", 0)),
            word_es_id=int(primitives.get("word_es_id", 0)),
            lang_code=str(primitives.get("lang_code", "")).strip(),
            text=str(primitives.get("text", "")).strip(),
            pronunciation=str(primitives.get("pronunciation", "") or "").strip(),
            audio_path=str(primitives.get("audio_path", "") or "").strip(),
            notes=str(primitives.get("notes", "") or "").strip(),
            created_at=str(primitives.get("created_at", "") or ""),
            updated_at=str(primitives.get("updated_at", "") or ""),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.id,
            "word_es_id": self.word_es_id,
            "lang_code": self.lang_code,
            "text": self.text,
            "pronunciation": self.pronunciation,
            "audio_path": self.audio_path,
            "notes": self.notes,
            "created_at": self.created_at,
            "updated_at": self.updated_at,
        }
