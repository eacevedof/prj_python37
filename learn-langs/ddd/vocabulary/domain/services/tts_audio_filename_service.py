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
    _NOTICE_PREFIX: str = TtsAudioFileEnum.NOTICE_PREFIX.value
    _EXTENSION: str = TtsAudioFileEnum.EXTENSION.value
    _TEMP_SUFFIX: str = TtsAudioFileEnum.TEMP_SUFFIX.value

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_filename(self, word_id: int, lang_code: str) -> str:
        """Nombre del audio definitivo (el ideal) de la palabra+idioma."""
        return (
            f"{self._NAME_PREFIX}{word_id}-"
            f"{self._get_accent_label(lang_code)}{self._EXTENSION}"
        )

    def get_temp_filename(self, word_id: int, lang_code: str) -> str:
        """Nombre del audio temporal (propuesta pendiente de aceptar/descartar)."""
        filename = self.get_filename(word_id, lang_code)
        return filename.replace(self._EXTENSION, f"{self._TEMP_SUFFIX}{self._EXTENSION}")

    def get_notice_filename(self, notice_key: str, lang_code: str) -> str:
        """Nombre del audio de un aviso hablado (no es una palabra del vocabulario).

        Prefijo propio (`notice-`) para que el sync al CDN lo ignore: allí solo
        viajan los `word-<id>-…`, que tienen fila en `words_es`.
        """
        return (
            f"{self._NOTICE_PREFIX}{notice_key}-"
            f"{self._get_accent_label(lang_code)}{self._EXTENSION}"
        )

    def _get_accent_label(self, lang_code: str) -> str:
        """Etiqueta del acento configurado para el idioma (o el propio código)."""
        accent = TtsAccentEnum.for_lang(lang_code)
        return accent.label if accent else lang_code.lower().replace("_", "-")
