from typing import Self, final

from src.modules.voice_mod.application.get_last_reply.get_last_reply_dto import GetLastReplyDto
from src.modules.voice_mod.application.get_last_reply.get_last_reply_service import (
    GetLastReplyService,
)
from src.modules.voice_mod.application.speak_last_reply.speak_last_reply_dto import (
    SpeakLastReplyDto,
)
from src.modules.voice_mod.application.speak_text.speak_text_dto import SpeakTextDto
from src.modules.voice_mod.application.speak_text.speak_text_result_dto import SpeakTextResultDto
from src.modules.voice_mod.application.speak_text.speak_text_service import SpeakTextService


@final
class SpeakLastReplyService:
    """Caso de uso del hook `Stop`: leer en alto la última respuesta de Claude."""

    _get_last_reply_service: GetLastReplyService
    _speak_text_service: SpeakTextService

    def __init__(self) -> None:
        self._get_last_reply_service = GetLastReplyService.get_instance()
        self._speak_text_service = SpeakTextService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __call__(self, speak_last_reply_dto: SpeakLastReplyDto) -> SpeakTextResultDto:
        """
        Raises:
            VoiceException: si el transcript no existe o no trae respuesta, o si
                falla la lectura en alto.
        """
        get_last_reply_result_dto = self._get_last_reply_service(
            GetLastReplyDto.from_primitives({"transcript_path": speak_last_reply_dto.transcript_path})
        )
        return self._speak_text_service(
            SpeakTextDto.from_primitives({"text": get_last_reply_result_dto.reply_text})
        )
