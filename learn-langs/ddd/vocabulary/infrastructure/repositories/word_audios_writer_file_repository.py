"""Repositorio de escritura de audios mp3 de palabras (datasource: file)."""

from pathlib import Path
from typing import final, Self

from ddd.shared.infrastructure.components.retrying_file_mover import RetryingFileMover
from ddd.vocabulary.domain.services.tts_audio_filename_service import TtsAudioFilenameService


@final
class WordAudiosWriterFileRepository:
    """Escritura/borrado de los mp3 de pronunciación en data/audio (datasource: file)."""

    # Ruta absoluta a data/audio (independiente del CWD): parents[4] = raíz del proyecto
    _AUDIO_DIR = Path(__file__).resolve().parents[4] / "data" / "audio"

    def __init__(self) -> None:
        # Los renombrados/borrados toleran locks transitorios (Windows) via componente.
        self._retrying_file_mover = RetryingFileMover.get_instance()
        self._tts_audio_filename_service = TtsAudioFilenameService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def save_audio(self, word_id: int, lang_code: str, audio_bytes: bytes) -> str:
        """Guarda el audio definitivo de la palabra+idioma y devuelve su ruta."""
        self._AUDIO_DIR.mkdir(parents=True, exist_ok=True)
        audio_path = self._AUDIO_DIR / self._tts_audio_filename_service.get_filename(word_id, lang_code)
        audio_path.write_bytes(audio_bytes)
        return str(audio_path)

    def save_temp_audio(self, word_id: int, lang_code: str, audio_bytes: bytes) -> str:
        """Guarda la propuesta temporal y devuelve su ruta."""
        self._AUDIO_DIR.mkdir(parents=True, exist_ok=True)
        temp_path = self._AUDIO_DIR / self._tts_audio_filename_service.get_temp_filename(word_id, lang_code)
        temp_path.write_bytes(audio_bytes)
        return str(temp_path)

    def delete_audio(self, word_id: int, lang_code: str) -> None:
        audio_path = self._AUDIO_DIR / self._tts_audio_filename_service.get_filename(word_id, lang_code)
        self._retrying_file_mover.remove(audio_path)

    def delete_temp_audio(self, word_id: int, lang_code: str) -> None:
        temp_path = self._AUDIO_DIR / self._tts_audio_filename_service.get_temp_filename(word_id, lang_code)
        self._retrying_file_mover.remove(temp_path)

    def promote_temp_audio(self, word_id: int, lang_code: str) -> str:
        """Convierte la propuesta temporal en el audio definitivo y devuelve su ruta.

        El renombrado tolera el lock transitorio de Windows (WinError 5) via el
        componente RetryingFileMover (reintento + fallback copiar/borrar).
        """
        temp_path = self._AUDIO_DIR / self._tts_audio_filename_service.get_temp_filename(word_id, lang_code)
        audio_path = self._AUDIO_DIR / self._tts_audio_filename_service.get_filename(word_id, lang_code)

        self._retrying_file_mover.replace(temp_path, audio_path)
        return str(audio_path)
