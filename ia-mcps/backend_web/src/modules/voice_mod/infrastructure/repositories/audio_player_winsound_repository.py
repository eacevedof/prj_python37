import sys
from typing import Self, final

from src.modules.voice_mod.domain.exceptions.voice_exception import VoiceException


@final
class AudioPlayerWinsoundRepository:
    """Reproducción de audio por los altavoces de esta máquina (datasource: winsound).

    `winsound` es de la librería estándar y reproduce un WAV desde memoria sin
    dependencias, pero solo existe en Windows. Para Linux/WSL, o para cortar el
    audio cuando se le interrumpe (fase 4), se cambiará por `sounddevice`.
    """

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def play_wav_bytes(self, wav_bytes: bytes) -> None:
        """Bloqueante: vuelve cuando el audio ha terminado.

        Raises:
            VoiceException: si la máquina no es Windows.
        """
        if sys.platform != "win32":
            VoiceException.unexpected_custom("audio playback is only supported on Windows for now")

        import winsound

        winsound.PlaySound(wav_bytes, winsound.SND_MEMORY)
