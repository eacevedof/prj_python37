"""Extensiones de fichero admitidas en word_es_media (columna file_ext)."""

from enum import Enum


class MediaFileExtEnum(str, Enum):
    """Tipo de media por extensión: hoy solo audio; vídeo/pdf en el futuro."""

    MP3 = "mp3"
