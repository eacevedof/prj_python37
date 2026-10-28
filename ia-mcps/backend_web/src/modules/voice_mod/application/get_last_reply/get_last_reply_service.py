from typing import Any, Self, final

from src.modules.voice_mod.application.get_last_reply.get_last_reply_dto import (
    GetLastReplyDto,
)
from src.modules.voice_mod.application.get_last_reply.get_last_reply_result_dto import (
    GetLastReplyResultDto,
)
from src.modules.voice_mod.domain.exceptions.voice_exception import VoiceException
from src.modules.voice_mod.infrastructure.repositories.transcript_reader_jsonl_repository import (
    TranscriptReaderJsonlRepository,
)

_ROLE_USER = "user"
_ROLE_ASSISTANT = "assistant"
_BLOCK_TEXT = "text"


@final
class GetLastReplyService:
    """Caso de uso: sacar del transcript lo que Claude ha contestado en el último turno.

    Un turno de Claude ocupa varias líneas del `.jsonl` (texto, llamadas a tools,
    más texto) y entre medias hay líneas `user` que solo llevan `tool_result`. El
    turno empieza en la última línea `user` que trae texto escrito por la
    persona; desde ahí se juntan los bloques de texto del asistente. Las líneas
    de subagentes (`isSidechain`) no cuentan.
    """

    _transcript_reader_jsonl_repository: TranscriptReaderJsonlRepository

    def __init__(self) -> None:
        self._transcript_reader_jsonl_repository = TranscriptReaderJsonlRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __call__(self, get_last_reply_dto: GetLastReplyDto) -> GetLastReplyResultDto:
        """
        Raises:
            VoiceException: si no llega ruta de transcript o el fichero no existe.
        """
        if not get_last_reply_dto.transcript_path:
            VoiceException.bad_request_custom("transcript_path is required")

        transcript_entries = [
            transcript_entry
            for transcript_entry in self._transcript_reader_jsonl_repository.get_entries(
                get_last_reply_dto.transcript_path
            )
            if not transcript_entry.get("isSidechain")
        ]

        reply_texts: list[str] = []
        for transcript_entry in transcript_entries:
            if self.__is_user_prompt(transcript_entry):
                reply_texts = []
                continue
            if transcript_entry.get("type") == _ROLE_ASSISTANT:
                reply_texts.extend(self.__get_text_blocks(transcript_entry))

        return GetLastReplyResultDto.from_primitives({"reply_text": "\n\n".join(reply_texts)})

    def __is_user_prompt(self, transcript_entry: dict[str, Any]) -> bool:
        if transcript_entry.get("type") != _ROLE_USER:
            return False

        message_content = self.__get_message_content(transcript_entry)
        if isinstance(message_content, str):
            return bool(message_content.strip())
        if isinstance(message_content, list):
            return any(
                isinstance(content_block, dict) and content_block.get("type") == _BLOCK_TEXT
                for content_block in message_content
            )
        return False

    def __get_text_blocks(self, transcript_entry: dict[str, Any]) -> list[str]:
        message_content = self.__get_message_content(transcript_entry)
        if isinstance(message_content, str):
            return [message_content] if message_content.strip() else []
        if not isinstance(message_content, list):
            return []
        return [
            str(content_block.get("text", ""))
            for content_block in message_content
            if isinstance(content_block, dict)
            and content_block.get("type") == _BLOCK_TEXT
            and str(content_block.get("text", "")).strip()
        ]

    def __get_message_content(self, transcript_entry: dict[str, Any]) -> Any:
        transcript_message = transcript_entry.get("message")
        if not isinstance(transcript_message, dict):
            return None
        return transcript_message.get("content")
