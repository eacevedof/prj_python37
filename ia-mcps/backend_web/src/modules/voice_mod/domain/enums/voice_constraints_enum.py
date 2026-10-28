from enum import IntEnum
from typing import final


@final
class VoiceConstraintsEnum(IntEnum):
    """Límites de voice_mod."""

    # Lo que se lee de una respuesta. Una respuesta larga leída entera son
    # minutos de audio y créditos; el resumen con Haiku es la fase 1.1.
    MAX_SPEECH_CHARS = 600
    FISH_AUDIO_TIMEOUT_SECONDS = 60
