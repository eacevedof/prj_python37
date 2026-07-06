"""Repositorio de escritura de audios mp3 de palabras (datasource: file)."""

from pathlib import Path
from typing import final, Self

from ddd.vocabulary.domain.services.tts_audio_filename_service import TtsAudioFilenameService


@final
class WordAudiosWriterFileRepository:
    """Escritura/borrado de los mp3 de pronunciación en data/audio (datasource: file)."""

    _AUDIO_DIR = Path("data/audio")

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def save_temp_audio(self, word_id: int, lang_code: str, audio_bytes: bytes) -> str:
        """Guarda la propuesta temporal y devuelve su ruta."""
        self._AUDIO_DIR.mkdir(parents=True, exist_ok=True)
        temp_path = self._AUDIO_DIR / TtsAudioFilenameService.get_temp_filename(word_id, lang_code)
        temp_path.write_bytes(audio_bytes)
        return str(temp_path)

    def delete_audio(self, word_id: int, lang_code: str) -> None:
        audio_path = self._AUDIO_DIR / TtsAudioFilenameService.get_filename(word_id, lang_code)
        audio_path.unlink(missing_ok=True)

    def delete_temp_audio(self, word_id: int, lang_code: str) -> None:
        temp_path = self._AUDIO_DIR / TtsAudioFilenameService.get_temp_filename(word_id, lang_code)
        temp_path.unlink(missing_ok=True)

    def promote_temp_audio(self, word_id: int, lang_code: str) -> str:
        """Convierte la propuesta temporal en el audio definitivo y devuelve su ruta."""
        temp_path = self._AUDIO_DIR / TtsAudioFilenameService.get_temp_filename(word_id, lang_code)
        audio_path = self._AUDIO_DIR / TtsAudioFilenameService.get_filename(word_id, lang_code)
        temp_path.replace(audio_path)
        return str(audio_path)
