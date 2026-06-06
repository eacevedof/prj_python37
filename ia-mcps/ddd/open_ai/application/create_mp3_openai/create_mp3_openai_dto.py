"""DTO para crear audio MP3 con OpenAI Audio API."""

from dataclasses import dataclass
from typing import Literal


@dataclass(frozen=True, slots=True)
class CreateMp3OpenaiDto:
    """
    DTO para parametrizar la generación de audio TTS con OpenAI.

    Soporta tanto tts-1 como tts-1-hd con múltiples voces y formatos.
    """

    text: str
    """Texto a convertir en audio (máximo 4096 caracteres)."""

    voice: Literal["alloy", "echo", "fable", "onyx", "nova", "shimmer"] = "alloy"
    """
    Voz a utilizar:
    - alloy: Neutral, versátil
    - echo: Masculina, clara
    - fable: Británica, expresiva
    - onyx: Masculina, profunda
    - nova: Femenina, energética
    - shimmer: Femenina, suave
    """

    model: Literal["tts-1", "tts-1-hd"] = "tts-1"
    """Modelo a utilizar (tts-1 es más rápido, tts-1-hd tiene mejor calidad)."""

    speed: float = 1.0
    """Velocidad del audio (0.25 a 4.0)."""

    response_format: Literal["mp3", "opus", "aac", "flac", "wav", "pcm"] = "mp3"
    """Formato de audio de salida."""

    def __post_init__(self) -> None:
        """Valida los parámetros del DTO."""
        if not self.text or not self.text.strip():
            raise ValueError("CreateMp3OpenaiDto: text no puede estar vacío")

        if len(self.text) > 4096:
            raise ValueError("CreateMp3OpenaiDto: text no puede exceder 4096 caracteres")

        if not 0.25 <= self.speed <= 4.0:
            raise ValueError("CreateMp3OpenaiDto: speed debe estar entre 0.25 y 4.0")
