from enum import StrEnum
from typing import final


@final
class OpenaiTtsModelEnum(StrEnum):
    """OpenAI models for TTS audio generation."""

    TTS_1 = "tts-1"
    TTS_1_HD = "tts-1-hd"

"""
┌──────────┬──────────────┬─────────────────────────────────────────────────────────┐
│  Modelo  │     Uso      │                     Características                     │
├──────────┼──────────────┼─────────────────────────────────────────────────────────┤
│ tts-1    │ General      │ Rápido, menor latencia, calidad estándar, más económico │
├──────────┼──────────────┼─────────────────────────────────────────────────────────┤
│ tts-1-hd │ Alta calidad │ Mayor latencia, mejor calidad de audio, más costoso     │
└──────────┴──────────────┴─────────────────────────────────────────────────────────┘
Criterio de selección:
- Usa tts-1 por defecto (buen balance calidad/velocidad/costo)
- Usa tts-1-hd cuando necesites audio para producción o presentaciones
"""
