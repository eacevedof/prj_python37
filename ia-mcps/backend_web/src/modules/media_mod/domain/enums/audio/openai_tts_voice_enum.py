from enum import StrEnum
from typing import final


@final
class OpenaiTtsVoiceEnum(StrEnum):
    """Available voices for TTS with OpenAI."""

    ALLOY = "alloy"
    ECHO = "echo"
    FABLE = "fable"
    ONYX = "onyx"
    NOVA = "nova"
    SHIMMER = "shimmer"

"""
┌─────────┬─────────────────────────────┐
│   Voz   │       Características       │
├─────────┼─────────────────────────────┤
│ alloy   │ Neutral, versátil (default) │
├─────────┼─────────────────────────────┤
│ echo    │ Masculina, clara            │
├─────────┼─────────────────────────────┤
│ fable   │ Expresiva, británica        │
├─────────┼─────────────────────────────┤
│ onyx    │ Profunda, masculina         │
├─────────┼─────────────────────────────┤
│ nova    │ Femenina, amigable          │
├─────────┼─────────────────────────────┤
│ shimmer │ Suave, femenina             │
└─────────┴─────────────────────────────┘
Criterio de selección:
- Depende del tono/género deseado para tu aplicación
- Prueba 2-3 voces y elige la que mejor se adapte a tu contenido
"""