from typing import Self, final

from src.modules.voice_mod.application.get_speech_text.get_speech_text_dto import (
    GetSpeechTextDto,
)
from src.modules.voice_mod.application.get_speech_text.get_speech_text_service import (
    GetSpeechTextService,
)
from src.modules.voice_mod.application.speak_text.speak_text_dto import SpeakTextDto
from src.modules.voice_mod.application.speak_text.speak_text_result_dto import (
    SpeakTextResultDto,
)
from src.modules.voice_mod.domain.enums import (
    FishAudioModelEnum,
    FishAudioVoiceEnum,
    VoiceMessageEnum,
    VoiceResultKeyEnum,
)
from src.modules.voice_mod.domain.exceptions.voice_exception import VoiceException
from src.modules.voice_mod.infrastructure.repositories.audio_writer_winsound_repository import (
    AudioWriterWinsoundRepository,
)
from src.modules.voice_mod.infrastructure.repositories.fish_audio_tts_reader_api_repository import (
    FishAudioTtsReaderApiRepository,
)


@final
class SpeakTextService:
    """Caso de uso: leer un texto en alto por los altavoces de esta máquina.

    Limpia el markdown, pide el audio a Fish Audio y lo reproduce. Es bloqueante:
    vuelve cuando el audio ha terminado de sonar.
    """

    _get_speech_text_service: GetSpeechTextService
    _fish_audio_tts_reader_api_repository: FishAudioTtsReaderApiRepository
    _audio_writer_winsound_repository: AudioWriterWinsoundRepository

    def __init__(self) -> None:
        self._get_speech_text_service = GetSpeechTextService.get_instance()
        self._fish_audio_tts_reader_api_repository = FishAudioTtsReaderApiRepository.get_instance()
        self._audio_writer_winsound_repository = AudioWriterWinsoundRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __call__(self, speak_text_dto: SpeakTextDto) -> SpeakTextResultDto:
        """
        Raises:
            VoiceException: si no queda texto que leer, falta la API key, Fish
                Audio no devuelve audio o la máquina no puede reproducirlo.
            HTTPError, URLError: si Fish Audio responde con error o no se alcanza.
        """
        get_speech_text_result_dto = self._get_speech_text_service(
            GetSpeechTextDto.from_primitives({
                VoiceResultKeyEnum.TEXT: speak_text_dto.text,
                VoiceResultKeyEnum.MAX_CHARS: speak_text_dto.max_chars,
            })
        )
        speech_text = get_speech_text_result_dto.speech_text
        if not speech_text:
            VoiceException.bad_request_custom(VoiceMessageEnum.NO_TEXT_TO_SPEAK)

        model = speak_text_dto.model or FishAudioModelEnum.S2_1_PRO_FREE
        reference_id = speak_text_dto.reference_id or FishAudioVoiceEnum.SARAH_EN

        wav_bytes = self._fish_audio_tts_reader_api_repository.get_wav_bytes_from_text(
            speech_text, model, reference_id
        )
        self._audio_writer_winsound_repository.play_wav_bytes(wav_bytes)

        return SpeakTextResultDto.from_primitives({
            VoiceResultKeyEnum.MODEL: model,
            VoiceResultKeyEnum.REFERENCE_ID: reference_id,
            VoiceResultKeyEnum.SPEECH_TEXT: speech_text,
            VoiceResultKeyEnum.SPOKEN_CHARS: len(speech_text),
        })
