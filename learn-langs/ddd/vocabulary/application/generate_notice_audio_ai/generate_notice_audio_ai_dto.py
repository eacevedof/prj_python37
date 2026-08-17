"""DTO de entrada para GenerateNoticeAudioAiService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class GenerateNoticeAudioAiDto:
    """DTO de entrada para generar el audio de un aviso hablado.

    Un aviso no es vocabulario (no tiene fila en words_es): se cachea por su
    clave (`notice_key`), que es la que nombra el mp3. Texto y clave salen del
    mismo miembro de SessionNoticeEnum.
    """

    notice_key: str = ""
    text: str = ""
    lang_code: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            notice_key=str(primitives.get("notice_key", "")).strip(),
            text=str(primitives.get("text", "")).strip(),
            lang_code=str(primitives.get("lang_code", "")).strip(),
        )
