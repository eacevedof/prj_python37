"""Enumerado de acentos de síntesis de voz (TTS) disponibles."""

from enum import Enum

from ddd.vocabulary.domain.enums.language_code_enum import LanguageCodeEnum


class TtsAccentEnum(Enum):
    """Acentos disponibles para la síntesis de voz con gpt-4o-mini-tts.

    Cada acento define tres datos:
    - lang_code:     idioma destino (valor de LanguageCodeEnum).
    - label:         etiqueta para el nombre de fichero (word-<id>-<label>.mp3).
    - instructions:  prompt de acento que se envía a gpt-4o-mini-tts.

    Para añadir un acento nuevo, agrega un miembro. Si es para un idioma que ya
    tiene acento, sustituye el existente (for_lang devuelve el primero que coincide).
    Ejemplos futuros: EN_US_TEXAS, NL_AMSTERDAM, NL_VLAAMS, DE_HOCHDEUTSCH...
    """

    ES_CASTELLANO = (
        LanguageCodeEnum.ES_ES.value,
        "es-es-castellano",
        "Habla en español de España, con acento castellano peninsular. "
        "No uses acento latinoamericano.",
    )
    NL_HAARLEM = (
        LanguageCodeEnum.NL_NL.value,
        "nl-nl-haarlem",
        "Spreek Standaardnederlands (ABN) zoals in Nederland, "
        "met het neutrale Randstad/Haarlem-accent. "
        "Gebruik geen Vlaams of Belgisch accent.",
    )

    def __init__(self, lang_code: str, label: str, instructions: str) -> None:
        self.lang_code = lang_code
        self.label = label
        self.instructions = instructions

    @classmethod
    def for_lang(cls, lang_code: str) -> "TtsAccentEnum | None":
        """Devuelve el acento configurado para un idioma, o None si no hay."""
        for accent in cls:
            if accent.lang_code == lang_code:
                return accent
        return None
