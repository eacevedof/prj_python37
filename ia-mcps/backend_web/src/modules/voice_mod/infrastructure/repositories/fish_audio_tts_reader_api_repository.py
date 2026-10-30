import json
import struct
from typing import Any, Self, final
from urllib.request import Request, urlopen

from src.modules.shared.infrastructure.repositories.configuration.environment_reader_raw_repository import (
    EnvironmentReaderRawRepository,
)
from src.modules.voice_mod.domain.enums import VoiceConstraintsEnum, VoiceMessageEnum
from src.modules.voice_mod.domain.exceptions.voice_exception import VoiceException

_FISH_AUDIO_TTS_URL = "https://api.fish.audio/v1/tts"
_WAV_FORMAT = "wav"
_RIFF_HEADER_BYTES = 12
_CHUNK_HEADER_BYTES = 8

# https://www.youtube.com/shorts/5CRrrmbQQ7Q
# https://docs.fish.audio/developer-guide/core-features/text-to-speech
@final
class FishAudioTtsReaderApiRepository:
    """Texto a voz con la API REST de Fish Audio (datasource: api).

    Pide el audio entero en WAV. El streaming por WebSocket (`/v1/tts/live`) para
    bajar la latencia queda para cuando la fase 1 esté probada.

    Como en media_mod, la API key se exige en el PRIMER USO y no al construir:
    sin `APP_VOICE_FISH_API_KEY` solo falla la voz, no el arranque de la app.
    """

    _environment_reader_raw_repository: EnvironmentReaderRawRepository

    def __init__(self) -> None:
        self._environment_reader_raw_repository = EnvironmentReaderRawRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_wav_bytes_from_text(self, speech_text: str, model: str, reference_id: str) -> bytes:
        """
        Raises:
            VoiceException: si falta la API key o la API no devuelve audio.
            HTTPError, URLError: si la API responde con error o no se alcanza.
        """
        fish_audio_api_key = self._environment_reader_raw_repository.get_voice_fish_api_key()
        if not fish_audio_api_key:
            VoiceException.bad_request_custom(VoiceMessageEnum.FISH_API_KEY_NOT_CONFIGURED)

        tts_payload: dict[str, Any] = {"text": speech_text, "format": _WAV_FORMAT}
        if reference_id:
            tts_payload["reference_id"] = reference_id

        tts_request = Request(
            _FISH_AUDIO_TTS_URL,
            data=json.dumps(tts_payload).encode("utf-8"),
            headers={
                "Authorization": f"Bearer {fish_audio_api_key}",
                "Content-Type": "application/json",
                "model": model,
            },
            method="POST",
        )

        with urlopen(
            tts_request, timeout=VoiceConstraintsEnum.FISH_AUDIO_TIMEOUT_SECONDS
        ) as tts_response:
            wav_bytes: bytes = tts_response.read()

        if not wav_bytes:
            VoiceException.unexpected_custom(VoiceMessageEnum.FISH_AUDIO_NO_AUDIO)
        return self._get_wav_with_real_sizes(wav_bytes)

    def _get_wav_with_real_sizes(self, wav_bytes: bytes) -> bytes:
        """Fish manda el WAV en streaming: los tamaños RIFF y `data` de la cabecera
        van a ~4 GB porque no sabe cuánto ocupará. `winsound.PlaySound` se fía de
        ellos, lee fuera del buffer y tumba el proceso (access violation). Aquí se
        reescriben con los tamaños reales."""
        if wav_bytes[:4] != b"RIFF" or wav_bytes[8:12] != b"WAVE":
            return wav_bytes
        fixed_wav = bytearray(wav_bytes)
        fixed_wav[4:8] = struct.pack("<I", len(wav_bytes) - _CHUNK_HEADER_BYTES)
        chunk_offset = _RIFF_HEADER_BYTES
        while chunk_offset + _CHUNK_HEADER_BYTES <= len(wav_bytes):
            chunk_id = wav_bytes[chunk_offset:chunk_offset + 4]
            data_offset = chunk_offset + _CHUNK_HEADER_BYTES
            if chunk_id == b"data":
                fixed_wav[chunk_offset + 4:data_offset] = struct.pack("<I", len(wav_bytes) - data_offset)
                return bytes(fixed_wav)
            chunk_size = struct.unpack("<I", wav_bytes[chunk_offset + 4:data_offset])[0]
            chunk_offset = data_offset + chunk_size + chunk_size % 2
        return bytes(fixed_wav)
