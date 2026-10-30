from typing import Self, final

from src.modules.voice_mod.application.listen_user_prompt.listen_user_prompt_dto import (
    ListenUserPromptDto,
)
from src.modules.voice_mod.application.listen_user_prompt.listen_user_prompt_result_dto import (
    ListenUserPromptResultDto,
)
from src.modules.voice_mod.domain.enums import VoiceConstraintsEnum, VoiceResultKeyEnum
from src.modules.voice_mod.infrastructure.repositories.audio_writer_winsound_repository import (
    AudioWriterWinsoundRepository,
)
from src.modules.voice_mod.infrastructure.repositories.push_to_talk_audio_reader_win32_repository import (
    PushToTalkAudioReaderWin32Repository,
)
from src.modules.voice_mod.infrastructure.repositories.speech_to_text_reader_faster_whisper_repository import (
    SpeechToTextReaderFasterWhisperRepository,
)


@final
class ListenUserPromptService:
    """Caso de uso: escuchar una instrucción por voz y devolverla en texto.

    Carga el modelo, pita («ya te escucho»), graba mientras mantienes pulsado
    Ctrl+Alt+Espacio, pita al soltar («recibido») y transcribe en local.
    Bloqueante. Hoy corre dentro del proceso del hook; en la fase 2a completa
    pasará al proceso residente de `make dev`, con el modelo ya cargado.
    """

    _speech_to_text_reader_faster_whisper_repository: SpeechToTextReaderFasterWhisperRepository
    _push_to_talk_audio_reader_win32_repository: PushToTalkAudioReaderWin32Repository
    _audio_writer_winsound_repository: AudioWriterWinsoundRepository

    def __init__(self) -> None:
        self._speech_to_text_reader_faster_whisper_repository = SpeechToTextReaderFasterWhisperRepository.get_instance()
        self._push_to_talk_audio_reader_win32_repository = PushToTalkAudioReaderWin32Repository.get_instance()
        self._audio_writer_winsound_repository = AudioWriterWinsoundRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __call__(self, listen_user_prompt_dto: ListenUserPromptDto) -> ListenUserPromptResultDto:
        """
        Raises:
            VoiceException: si no es Windows o no se instala el hook de teclado.
            Exception: lo que lancen faster-whisper (modelo) o sounddevice (micro).
        """
        self._speech_to_text_reader_faster_whisper_repository.load_model()
        self._audio_writer_winsound_repository.play_beep(VoiceConstraintsEnum.READY_BEEP_HZ, VoiceConstraintsEnum.BEEP_MS)

        sample_rate = VoiceConstraintsEnum.RECORD_SAMPLE_RATE
        audio_samples = self._push_to_talk_audio_reader_win32_repository.get_samples_while_key_held(
            listen_user_prompt_dto.wait_seconds,
            listen_user_prompt_dto.max_record_seconds,
            sample_rate,
        )
        recorded_seconds = round(len(audio_samples) / sample_rate, 2)
        if recorded_seconds * 1000 < VoiceConstraintsEnum.MIN_RECORDED_MS:
            return ListenUserPromptResultDto.from_primitives({
                VoiceResultKeyEnum.RECORDED_SECONDS: recorded_seconds,
            })

        self._audio_writer_winsound_repository.play_beep(VoiceConstraintsEnum.DONE_BEEP_HZ, VoiceConstraintsEnum.BEEP_MS)
        prompt_text = self._speech_to_text_reader_faster_whisper_repository.get_text_from_samples(audio_samples)
        return ListenUserPromptResultDto.from_primitives({
            VoiceResultKeyEnum.PROMPT_TEXT: prompt_text,
            VoiceResultKeyEnum.RECORDED_SECONDS: recorded_seconds,
        })
