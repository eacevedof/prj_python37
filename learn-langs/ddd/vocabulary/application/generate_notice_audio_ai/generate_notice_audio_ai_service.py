"""Servicio para generar el audio de un aviso hablado con IA (tts-1)."""

import asyncio
from typing import final, Self

from ddd.shared.infrastructure.components.logger import Logger
from ddd.open_ai.domain.enums import (
    OpenaiTtsConstraintsEnum,
    OpenaiTtsFormatEnum,
    OpenaiTtsModelEnum,
)
from ddd.open_ai.infrastructure.repositories import GptTts1ReaderApiRepository
from ddd.vocabulary.application.generate_notice_audio_ai.generate_notice_audio_ai_dto import (
    GenerateNoticeAudioAiDto,
)
from ddd.vocabulary.application.generate_notice_audio_ai.generate_notice_audio_ai_result_dto import (
    GenerateNoticeAudioAiResultDto,
)
from ddd.vocabulary.domain.enums import AudioSourceEnum, TtsAccentEnum
from ddd.vocabulary.domain.services import TtsVoiceSelectorService
from ddd.vocabulary.infrastructure.repositories.notice_audios_reader_file_repository import (
    NoticeAudiosReaderFileRepository,
)
from ddd.vocabulary.infrastructure.repositories.notice_audios_writer_file_repository import (
    NoticeAudiosWriterFileRepository,
)


@final
class GenerateNoticeAudioAiService:
    """Servicio para generar el audio de un aviso hablado (fin de sesión, ...).

    Hermano de GenerateTextAudioAiService pero desacoplado del vocabulario: el
    aviso no tiene fila en words_es, así que se cachea en data/audio por su
    clave (`notice-<clave>-<acento>.mp3`) y el sync al CDN lo ignora.
    """

    _NORMAL_SPEED: float = OpenaiTtsConstraintsEnum.NORMAL_SPEED.value

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._gpt_tts_1_reader_api_repository = GptTts1ReaderApiRepository.get_instance()
        self._notice_audios_reader_file_repository = (
            NoticeAudiosReaderFileRepository.get_instance()
        )
        self._notice_audios_writer_file_repository = (
            NoticeAudiosWriterFileRepository.get_instance()
        )
        self._tts_voice_selector_service = TtsVoiceSelectorService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self, generate_notice_audio_ai_dto: GenerateNoticeAudioAiDto
    ) -> GenerateNoticeAudioAiResultDto:
        """
        Genera (o reutiliza de cache) el audio del aviso.

        Args:
            generate_notice_audio_ai_dto: DTO con clave, texto e idioma.

        Returns:
            GenerateNoticeAudioAiResultDto con la ruta del audio o el error.
        """
        notice_key = generate_notice_audio_ai_dto.notice_key
        text_to_generate = generate_notice_audio_ai_dto.text
        lang_code = generate_notice_audio_ai_dto.lang_code

        if not notice_key:
            return GenerateNoticeAudioAiResultDto.error("Se requiere notice_key")

        if not text_to_generate:
            return GenerateNoticeAudioAiResultDto.error("No hay texto para generar audio")

        if self._notice_audios_reader_file_repository.has_audio(notice_key, lang_code):
            return GenerateNoticeAudioAiResultDto.ok(
                audio_path=self._notice_audios_reader_file_repository.get_audio_path(
                    notice_key, lang_code
                ),
                voice_used=AudioSourceEnum.CACHED.value,
                model_used=AudioSourceEnum.CACHED.value,
                text_generated=text_to_generate,
            )

        voice_used = self._tts_voice_selector_service.get_voice(lang_code)

        # Acento por idioma: con instrucción -> gpt-4o-mini-tts; si no -> tts-1
        accent = TtsAccentEnum.for_lang(lang_code)
        model_used = OpenaiTtsModelEnum.TTS_1.value
        instructions = accent.instructions if accent else ""
        if instructions:
            model_used = OpenaiTtsModelEnum.GPT_4O_MINI_TTS.value

        # En thread: la llamada a la API es sincrónica y bloquearía el event
        # loop de la UI
        audio_bytes = await asyncio.to_thread(
            self._gpt_tts_1_reader_api_repository.get_audio_bytes_from_text,
            model=model_used,
            voice=voice_used,
            input_text=text_to_generate,
            speed=self._NORMAL_SPEED,
            response_format=OpenaiTtsFormatEnum.MP3,
            instructions=instructions,
        )

        audio_path = self._notice_audios_writer_file_repository.save_audio(
            notice_key, lang_code, audio_bytes
        )

        self._logger.log_info(
            "GenerateNoticeAudioAiService",
            f"Audio de aviso generado: {audio_path} con voz '{voice_used}'",
        )

        return GenerateNoticeAudioAiResultDto.ok(
            audio_path=str(audio_path),
            voice_used=voice_used,
            model_used=model_used,
            text_generated=text_to_generate,
        )
