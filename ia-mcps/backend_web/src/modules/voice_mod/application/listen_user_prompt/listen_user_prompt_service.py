from typing import Self, final

from src.modules.voice_mod.application.listen_user_prompt.listen_user_prompt_dto import (
    ListenUserPromptDto,
)
from src.modules.voice_mod.application.listen_user_prompt.listen_user_prompt_result_dto import (
    ListenUserPromptResultDto,
)
from src.modules.voice_mod.domain.enums import VoiceConstraintsEnum
from src.modules.voice_mod.infrastructure.repositories.audio_player_winsound_repository import (
    AudioPlayerWinsoundRepository,
)
from src.modules.voice_mod.infrastructure.repositories.push_to_talk_recorder_win32_repository import (
    PushToTalkRecorderWin32Repository,
)
from src.modules.voice_mod.infrastructure.repositories.speech_to_text_faster_whisper_repository import (
    SpeechToTextFasterWhisperRepository,
)

_READY_BEEP_HZ = 880
_DONE_BEEP_HZ = 520
_BEEP_MS = 120
# Menos que esto es un toque de tecla sin querer, no una frase.
_MIN_RECORDED_SECONDS = 0.4


@final
class ListenUserPromptService:
    """Caso de uso: escuchar una instrucción por voz y devolverla en texto.

    Carga el modelo, pita («ya te escucho»), graba mientras mantienes pulsado
    Ctrl+Alt+Espacio, pita al soltar («recibido») y transcribe en local.
    Bloqueante. Hoy corre dentro del proceso del hook; en la fase 2a completa
    pasará al proceso residente de `make dev`, con el modelo ya cargado.
    """

    _speech_to_text_faster_whisper_repository: SpeechToTextFasterWhisperRepository
    _push_to_talk_recorder_win32_repository: PushToTalkRecorderWin32Repository
    _audio_player_winsound_repository: AudioPlayerWinsoundRepository

    def __init__(self) -> None:
        self._speech_to_text_faster_whisper_repository = SpeechToTextFasterWhisperRepository.get_instance()
        self._push_to_talk_recorder_win32_repository = PushToTalkRecorderWin32Repository.get_instance()
        self._audio_player_winsound_repository = AudioPlayerWinsoundRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __call__(self, listen_user_prompt_dto: ListenUserPromptDto) -> ListenUserPromptResultDto:
        """
        Raises:
            VoiceException: si el modelo no carga, no hay micro o no es Windows.
        """
        self._speech_to_text_faster_whisper_repository.load_model()
        self._audio_player_winsound_repository.play_beep(_READY_BEEP_HZ, _BEEP_MS)

        sample_rate = VoiceConstraintsEnum.RECORD_SAMPLE_RATE
        audio_samples = self._push_to_talk_recorder_win32_repository.get_samples_while_key_held(
            listen_user_prompt_dto.wait_seconds,
            listen_user_prompt_dto.max_record_seconds,
            sample_rate,
        )
        recorded_seconds = round(len(audio_samples) / sample_rate, 2)
        if recorded_seconds < _MIN_RECORDED_SECONDS:
            return ListenUserPromptResultDto.from_primitives({"recorded_seconds": recorded_seconds})

        self._audio_player_winsound_repository.play_beep(_DONE_BEEP_HZ, _BEEP_MS)
        prompt_text = self._speech_to_text_faster_whisper_repository.get_text_from_samples(audio_samples)
        return ListenUserPromptResultDto.from_primitives({
            "prompt_text": prompt_text,
            "recorded_seconds": recorded_seconds,
        })
