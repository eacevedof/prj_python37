"""Enumerado de acentos de síntesis de voz (TTS) disponibles."""

from enum import Enum

from ddd.vocabulary.domain.enums.language_code_enum import LanguageCodeEnum


class TtsAccentEnum(Enum):
    """Catálogo de acentos para la síntesis de voz con gpt-4o-mini-tts.

    Cada acento define tres datos:
    - lang_code:     idioma destino (valor de LanguageCodeEnum).
    - label:         etiqueta para el nombre de fichero (word-<id>-<label>.mp3).
    - instructions:  prompt de acento que se envía a gpt-4o-mini-tts.

    ⚠️ El acento ACTIVO de cada idioma es el PRIMER miembro que coincide con ese
    idioma (lo decide `for_lang`). Los demás del mismo idioma quedan como catálogo
    disponible. Para cambiar el activo de un idioma, mueve el miembro deseado al
    primer lugar de ese idioma (o pide un selector en runtime).

    Nota: los acentos regionales finos los aproxima el modelo (no es un simulador
    dialectal perfecto); los nacionales (España, Países Bajos, Bélgica) salen mejor.
    """

    # ── Español (activo: ES_CASTELLANO) ──────────────────────────────────────
    ES_CASTELLANO = (
        LanguageCodeEnum.ES_ES.value,
        "es-es-castellano",
        "Habla en español de España, con acento castellano peninsular. "
        "No uses acento latinoamericano.",
    )

    # ── Neerlandés de Países Bajos (activo: NL_HAARLEM) ──────────────────────
    NL_HAARLEM = (
        LanguageCodeEnum.NL_NL.value,
        "nl-nl-haarlem",
        "Spreek Standaardnederlands (ABN) zoals in Nederland, "
        "met het neutrale Randstad/Haarlem-accent. "
        "Gebruik geen Vlaams of Belgisch accent.",
    )
    NL_AMSTERDAM = (
        LanguageCodeEnum.NL_NL.value,
        "nl-nl-amsterdam",
        "Spreek Nederlands met een herkenbaar Amsterdams (Mokums) "
        "stadsaccent, plat en wat nasaal.",
    )
    NL_ROTTERDAM = (
        LanguageCodeEnum.NL_NL.value,
        "nl-nl-rotterdam",
        "Spreek Nederlands met een Rotterdams stadsaccent: direct en stoer, "
        "met een duidelijke harde R.",
    )
    NL_BRABANT = (
        LanguageCodeEnum.NL_NL.value,
        "nl-nl-brabant",
        "Spreek Nederlands met een zacht Brabants accent uit het zuiden "
        "van Nederland, met een zachte G.",
    )
    NL_GRONINGS = (
        LanguageCodeEnum.NL_NL.value,
        "nl-nl-gronings",
        "Spreek Nederlands met een Gronings accent uit het noorden "
        "van Nederland.",
    )

    # ── Neerlandés de Bélgica / Flamenco (activo: NL_VLAAMS) ──────────────────
    NL_VLAAMS = (
        LanguageCodeEnum.NL_BE.value,
        "nl-be-vlaams",
        "Spreek Vlaams (Belgisch-Nederlands) met een zachte, melodieuze "
        "Vlaamse uitspraak. Gebruik geen Nederlands-Nederlands accent.",
    )

    def __init__(self, lang_code: str, label: str, instructions: str) -> None:
        self.lang_code = lang_code
        self.label = label
        self.instructions = instructions

    @classmethod
    def for_lang(cls, lang_code: str) -> "TtsAccentEnum | None":
        """Devuelve el acento ACTIVO de un idioma (el primero que coincide), o None."""
        for accent in cls:
            if accent.lang_code == lang_code:
                return accent
        return None

    @classmethod
    def options_for_lang(cls, lang_code: str) -> list["TtsAccentEnum"]:
        """Devuelve todos los acentos disponibles para un idioma (catálogo)."""
        return [accent for accent in cls if accent.lang_code == lang_code]
