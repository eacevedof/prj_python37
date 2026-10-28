"""Repositorio de lectura de los mp3 de avisos hablados (datasource: file)."""

from pathlib import Path
from typing import final, Self

from ddd.vocabulary.domain.services.tts_audio_filename_service import (
    TtsAudioFilenameService,
)


@final
class NoticeAudiosReaderFileRepository:
    """Lectura de los mp3 de avisos (notice-*) en data/audio (datasource: file)."""

    # Ruta absoluta a data/audio (independiente del CWD): parents[4] = raíz del proyecto
    _AUDIO_DIR = Path(__file__).resolve().parents[4] / "data" / "audio"

    def __init__(self) -> None:
        self._tts_audio_filename_service = TtsAudioFilenameService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_audio_path(self, notice_key: str, lang_code: str) -> str:
        return str(
            self._AUDIO_DIR
            / self._tts_audio_filename_service.get_notice_filename(
                notice_key, lang_code
            )
        )

    def has_audio(self, notice_key: str, lang_code: str) -> bool:
        return Path(self.get_audio_path(notice_key, lang_code)).exists()
