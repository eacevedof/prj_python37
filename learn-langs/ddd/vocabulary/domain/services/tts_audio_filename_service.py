"""Servicio de dominio: nombre del fichero mp3 de una palabra+idioma."""

from typing import final

from ddd.vocabulary.domain.enums.tts_accent_enum import TtsAccentEnum


@final
class TtsAudioFilenameService:
    """Servicio de dominio: deriva el nombre del mp3 de pronunciación.

    Nombre autodocumentado: word-<id>-<accent-label>.mp3. Incluir el acento
    hace la caché autoinvalidante: si cambia el acento configurado (p.ej.
    Haarlem por defecto en nl_NL), cambia el nombre y el audio se regenera solo.
    """

    _TEMP_SUFFIX = "-temp"

    @staticmethod
    def get_filename(word_id: int, lang_code: str) -> str:
        """Nombre del audio definitivo (el ideal) de la palabra+idioma."""
        accent = TtsAccentEnum.for_lang(lang_code)
        accent_label = accent.label if accent else lang_code.lower().replace("_", "-")
        return f"word-{word_id}-{accent_label}.mp3"

    @classmethod
    def get_temp_filename(cls, word_id: int, lang_code: str) -> str:
        """Nombre del audio temporal (propuesta pendiente de aceptar/descartar)."""
        filename = cls.get_filename(word_id, lang_code)
        return filename.replace(".mp3", f"{cls._TEMP_SUFFIX}.mp3")
