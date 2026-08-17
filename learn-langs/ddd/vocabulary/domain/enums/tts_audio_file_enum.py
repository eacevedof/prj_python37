"""Piezas del nombre de fichero de los mp3 de pronunciación (TTS)."""

from enum import Enum


class TtsAudioFileEnum(str, Enum):
    """Convención del nombre: word-<id>-<accent-label>.mp3 (+ sufijo temporal).

    Incluir el acento en el nombre hace la caché autoinvalidante: si cambia el
    acento configurado para el idioma, cambia el nombre y el audio se regenera.

    Los avisos hablados (no son vocabulario) llevan su propio prefijo
    `notice-`: el sync al CDN solo sube los `word-<id>-…`, que son los que
    tienen fila en `words_es`.
    """

    NAME_PREFIX = "word-"
    NOTICE_PREFIX = "notice-"
    EXTENSION = ".mp3"
    TEMP_SUFFIX = "-temp"
