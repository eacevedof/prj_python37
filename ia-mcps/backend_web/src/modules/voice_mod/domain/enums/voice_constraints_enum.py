from enum import IntEnum
from typing import final


@final
class VoiceConstraintsEnum(IntEnum):
    """Límites de voice_mod."""

    # Lo que se lee de una respuesta. Una respuesta larga leída entera son
    # minutos de audio y créditos; el resumen con Haiku es la fase 1.1.
    MAX_SPEECH_CHARS = 600
    FISH_AUDIO_TIMEOUT_SECONDS = 60
    # Modo voz: cuánto espera el hook a que pulses la tecla antes de dejar parar
    # a Claude, y el tope de una frase. Ojo: el `timeout` del hook en
    # settings.json tiene que ser mayor que la suma (más la carga del modelo).
    LISTEN_WAIT_SECONDS = 240
    MAX_RECORD_SECONDS = 60
    RECORD_SAMPLE_RATE = 16000
    # Menos que esto es un toque de tecla sin querer, no una frase.
    MIN_RECORDED_MS = 400
    # Pitidos: «ya te escucho» (agudo) y «recibido» (grave).
    READY_BEEP_HZ = 880
    DONE_BEEP_HZ = 520
    BEEP_MS = 120
