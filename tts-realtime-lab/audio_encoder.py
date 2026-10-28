"""PCM 16-bit mono 24 kHz (lo que devuelve la Realtime API) -> wav / mp3.

- wav: solo stdlib; vale en cualquier plataforma, incluido el APK.
- mp3: lameenc (wheel nativo; hay que comprobar si existe para Android en
  pypi.flet.dev) y, si no está instalado, ffmpeg por subprocess (solo escritorio).
"""

import io
import shutil
import subprocess
import wave
from typing import final

SAMPLE_RATE = 24000
CHANNELS = 1
SAMPLE_WIDTH = 2  # 16-bit


@final
class AudioEncoder:
    @staticmethod
    def encode(pcm: bytes, response_format: str) -> bytes:
        if response_format == "pcm":
            return pcm
        if response_format == "wav":
            return AudioEncoder.to_wav(pcm)
        if response_format == "mp3":
            return AudioEncoder.to_mp3(pcm)
        raise ValueError(f"Formato no soportado: {response_format}")

    @staticmethod
    def to_wav(pcm: bytes) -> bytes:
        buffer = io.BytesIO()
        with wave.open(buffer, "wb") as wav_file:
            wav_file.setnchannels(CHANNELS)
            wav_file.setsampwidth(SAMPLE_WIDTH)
            wav_file.setframerate(SAMPLE_RATE)
            wav_file.writeframes(pcm)
        return buffer.getvalue()

    @staticmethod
    def to_mp3(pcm: bytes) -> bytes:
        try:
            import lameenc  # type: ignore[import-untyped]
        except ImportError:
            return AudioEncoder._to_mp3_with_ffmpeg(pcm)

        encoder = lameenc.Encoder()
        encoder.set_bit_rate(64)
        encoder.set_in_sample_rate(SAMPLE_RATE)
        encoder.set_channels(CHANNELS)
        encoder.set_quality(2)
        return bytes(encoder.encode(pcm) + encoder.flush())

    @staticmethod
    def _to_mp3_with_ffmpeg(pcm: bytes) -> bytes:
        ffmpeg = shutil.which("ffmpeg")
        if ffmpeg is None:
            raise RuntimeError("Para mp3 hace falta 'pip install lameenc' o ffmpeg en el PATH")
        completed = subprocess.run(
            [
                ffmpeg, "-hide_banner", "-loglevel", "error",
                "-f", "s16le", "-ar", str(SAMPLE_RATE), "-ac", str(CHANNELS), "-i", "pipe:0",
                "-b:a", "64k", "-f", "mp3", "pipe:1",
            ],
            input=pcm,
            capture_output=True,
            check=True,
        )
        return completed.stdout
