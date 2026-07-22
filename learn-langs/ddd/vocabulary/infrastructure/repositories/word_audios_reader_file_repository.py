"""Repositorio de lectura de audios mp3 de palabras (datasource: file)."""

from pathlib import Path
from typing import final, Self

from ddd.vocabulary.domain.services.tts_audio_filename_service import TtsAudioFilenameService


@final
class WordAudiosReaderFileRepository:
    """Lectura de los mp3 de pronunciación en data/audio (datasource: file)."""

    # Ruta absoluta a data/audio (independiente del CWD): parents[4] = raíz del proyecto
    _AUDIO_DIR = Path(__file__).resolve().parents[4] / "data" / "audio"

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_audio_path(self, word_id: int, lang_code: str) -> str:
        return str(self._AUDIO_DIR / TtsAudioFilenameService.get_filename(word_id, lang_code))

    def get_temp_audio_path(self, word_id: int, lang_code: str) -> str:
        return str(self._AUDIO_DIR / TtsAudioFilenameService.get_temp_filename(word_id, lang_code))

    def has_audio(self, word_id: int, lang_code: str) -> bool:
        return Path(self.get_audio_path(word_id, lang_code)).exists()

    def has_temp_audio(self, word_id: int, lang_code: str) -> bool:
        return Path(self.get_temp_audio_path(word_id, lang_code)).exists()
