"""Servicio de dominio: nombre del fichero mp3 de una palabra+idioma."""

from typing import Self, final

from ddd.vocabulary.domain.enums.tts_accent_enum import TtsAccentEnum
from ddd.vocabulary.domain.enums.tts_audio_file_enum import TtsAudioFileEnum


@final
class TtsAudioFilenameService:
    """Servicio de dominio: deriva el nombre del mp3 de pronunciación.

    Nombre autodocumentado: word-<id>-<accent-label>.mp3. Incluir el acento
    hace la caché autoinvalidante: si cambia el acento configurado (p.ej.
    Haarlem por defecto en nl_NL), cambia el nombre y el audio se regenera solo.
    """

    _NAME_PREFIX: str = TtsAudioFileEnum.NAME_PREFIX.value
    _EXTENSION: str = TtsAudioFileEnum.EXTENSION.value
    _TEMP_SUFFIX: str = TtsAudioFileEnum.TEMP_SUFFIX.value

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_filename(self, word_id: int, lang_code: str) -> str:
        """Nombre del audio definitivo (el ideal) de la palabra+idioma."""
        accent = TtsAccentEnum.for_lang(lang_code)
        accent_label = accent.label if accent else lang_code.lower().replace("_", "-")
        return f"{self._NAME_PREFIX}{word_id}-{accent_label}{self._EXTENSION}"

    def get_temp_filename(self, word_id: int, lang_code: str) -> str:
        """Nombre del audio temporal (propuesta pendiente de aceptar/descartar)."""
        filename = self.get_filename(word_id, lang_code)
        return filename.replace(self._EXTENSION, f"{self._TEMP_SUFFIX}{self._EXTENSION}")
