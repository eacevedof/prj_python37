from enum import StrEnum
from typing import final


@final
class OpenaiTtsFormatEnum(StrEnum):
    """Available audio formats for TTS with OpenAI."""

    MP3 = "mp3"
    OPUS = "opus"
    AAC = "aac"
    FLAC = "flac"
    WAV = "wav"
    PCM = "pcm"

"""
┌─────────┬───────────────────────────────────────────────────┐
│ Formato │                        Uso                        │
├─────────┼───────────────────────────────────────────────────┤
│ mp3     │ Web general (default, buen balance)               │
├─────────┼───────────────────────────────────────────────────┤
│ opus    │ Streaming (mejor compresión, ideal para internet) │
├─────────┼───────────────────────────────────────────────────┤
│ aac     │ Compatibilidad Apple/móvil                        │
├─────────┼───────────────────────────────────────────────────┤
│ flac    │ Sin pérdida (archivos grandes, máxima calidad)    │
├─────────┼───────────────────────────────────────────────────┤
│ wav     │ Producción/edición (sin compresión)               │
├─────────┼───────────────────────────────────────────────────┤
│ pcm     │ Raw audio (procesamiento bajo nivel)              │
└─────────┴───────────────────────────────────────────────────┘
Criterio de selección:
- mp3: Uso general, compatibilidad universal
- opus: Si necesitas menor tamaño de archivo
- flac/wav: Si necesitas editar o máxima calidad
"""