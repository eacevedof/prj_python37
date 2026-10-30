import re
from typing import Self, final

from src.modules.voice_mod.application.listen_user_prompt.listen_user_prompt_dto import (
    ListenUserPromptDto,
)
from src.modules.voice_mod.application.listen_user_prompt.listen_user_prompt_service import (
    ListenUserPromptService,
)
from src.modules.voice_mod.application.run_voice_turn.run_voice_turn_dto import (
    RunVoiceTurnDto,
)
from src.modules.voice_mod.application.run_voice_turn.run_voice_turn_result_dto import (
    RunVoiceTurnResultDto,
)
from src.modules.voice_mod.domain.enums import VoiceResultKeyEnum
from src.modules.voice_mod.infrastructure.repositories.voice_mode_writer_file_repository import (
    VoiceModeWriterFileRepository,
)

_STOP_VOICE_PATTERN = re.compile(r"^\W*fin\W+(de\W+)?voz\W*$", re.IGNORECASE)


@final
class RunVoiceTurnService:
    """Caso de uso del modo voz: escuchar la siguiente instrucción.

    Si lo que se dice es «fin voz» (o «fin de voz»), apaga el modo voz y no
    devuelve instrucción. Leer en alto la respuesta anterior NO es parte de este
    caso de uso: lo hace el hook antes, para que un fallo de Fish Audio no deje
    sin escucha el turno.
    """

    _listen_user_prompt_service: ListenUserPromptService
    _voice_mode_writer_file_repository: VoiceModeWriterFileRepository

    def __init__(self) -> None:
        self._listen_user_prompt_service = ListenUserPromptService.get_instance()
        self._voice_mode_writer_file_repository = VoiceModeWriterFileRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __call__(self, run_voice_turn_dto: RunVoiceTurnDto) -> RunVoiceTurnResultDto:
        """
        Raises:
            VoiceException, Exception: los de `ListenUserPromptService`.
        """
        listen_user_prompt_result_dto = self._listen_user_prompt_service(
            ListenUserPromptDto.from_primitives({
                VoiceResultKeyEnum.WAIT_SECONDS: run_voice_turn_dto.wait_seconds,
                VoiceResultKeyEnum.MAX_RECORD_SECONDS: run_voice_turn_dto.max_record_seconds,
            })
        )
        prompt_text = listen_user_prompt_result_dto.prompt_text
        if not prompt_text:
            return RunVoiceTurnResultDto.from_primitives({})

        if _STOP_VOICE_PATTERN.match(prompt_text):
            self._voice_mode_writer_file_repository.turn_voice_mode_off()
            return RunVoiceTurnResultDto.from_primitives({VoiceResultKeyEnum.IS_VOICE_MODE_STOPPED: True})

        return RunVoiceTurnResultDto.from_primitives({VoiceResultKeyEnum.PROMPT_TEXT: prompt_text})
