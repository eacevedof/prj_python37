import json
from typing import Any, Self, final
from urllib.error import HTTPError, URLError
from urllib.request import Request, urlopen

from src.modules.shared.infrastructure.repositories.configuration.environment_reader_raw_repository import (
    EnvironmentReaderRawRepository,
)

from src.modules.voice_mod.domain.enums import VoiceConstraintsEnum
from src.modules.voice_mod.domain.exceptions.voice_exception import VoiceException

_FISH_AUDIO_TTS_URL = "https://api.fish.audio/v1/tts"
_WAV_FORMAT = "wav"
_ERROR_BODY_MAX_CHARS = 300

# https://www.youtube.com/shorts/5CRrrmbQQ7Q
# https://docs.fish.audio/developer-guide/core-features/text-to-speech
@final
class FishAudioTtsApiRepository:
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
            VoiceException: si falta la API key, la API responde con error o no
                devuelve audio.
        """
        fish_audio_api_key = self._environment_reader_raw_repository.get_voice_fish_api_key()
        if not fish_audio_api_key:
            VoiceException.bad_request_custom("APP_VOICE_FISH_API_KEY is not configured")

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

        wav_bytes = b""
        try:
            with urlopen(
                tts_request, timeout=VoiceConstraintsEnum.FISH_AUDIO_TIMEOUT_SECONDS
            ) as tts_response:
                wav_bytes = tts_response.read()
        except HTTPError as http_error:
            error_body = http_error.read().decode("utf-8", "replace")[:_ERROR_BODY_MAX_CHARS]
            VoiceException.unexpected_custom(f"fish audio tts failed ({http_error.code}): {error_body}")
        except URLError as url_error:
            VoiceException.unexpected_custom(f"fish audio is unreachable: {url_error.reason}")

        if not wav_bytes:
            VoiceException.unexpected_custom("fish audio returned no audio")
        return wav_bytes
